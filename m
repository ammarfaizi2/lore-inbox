Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTIUFcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 01:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTIUFcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 01:32:21 -0400
Received: from web12803.mail.yahoo.com ([216.136.174.38]:34408 "HELO
	web12803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262333AbTIUFcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 01:32:10 -0400
Message-ID: <20030921053209.45935.qmail@web12803.mail.yahoo.com>
Date: Sat, 20 Sep 2003 22:32:09 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: A couple of 2.4.23-pre4 VM nits
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030921024649.GB16294@velociraptor.random>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1163173720-1064122329=:44957"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1163173720-1064122329=:44957
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Agreed on all counts.  I just blindly copied the
max_scan decrement from 2.4.22.  Even there your
suggestion would make sense.  Attached is a new patch
which adds support for vm_vfs_scan_interval sysctl and
also fixes the location of max_scan decrement.

Thanks,
Shantanu

--- Andrea Arcangeli <andrea@suse.de> wrote:
> Hi Shantanu,
> 
> On Sat, Sep 20, 2003 at 06:39:30AM -0700, Shantanu
> Goel wrote:
> > Hi Andrea,
> > 
> > The VM fixes perform rather well in my testing
> > (thanks!), but I noticed a couple of glitches that
> the
> > attached patch addresses.
> > 
> > 1. max_scan is never decremented in
> shrink_cache().  I
> > am assuming this is a typo.
> 
> this is an huge half-merging error, no surprise Andi
> run into vm
> troubles with pre4. My tree looks like this for
> years:
> 
> 		if (unlikely(!page_count(page)))
> 			continue;
> 
> 		only_metadata = 0;
> 		if (!memclass(page_zone(page), classzone)) {
> 			/*
> 			 * Hack to address an issue found by Rik. The
> 			 * problem is that
> 			 * highmem pages can hold buffer headers
> 			 * allocated
> 			 * from the slab on lowmem, and so if we are
> 			 * working
> 			 * on the NORMAL classzone here, it is correct
> 			 * not to
> 			 * try to free the highmem pages themself (that
> 			 * would be useless)
> 			 * but we must make sure to drop any lowmem
> 			 * metadata related to those
> 			 * highmem pages.
> 			 */
> 			if (page->buffers && page->mapping) { /* fast
> path racy check */
> 				if (unlikely(TryLockPage(page)))
> 					continue;
> 				if (page->buffers && page->mapping &&
> memclass_related_bhs(page, classzone)) { /* non racy
> check */
> 					only_metadata = 1;
> 					goto free_bhs;
> 				}
> 				UnlockPage(page);
> 			}
> 			continue;
> 		}
> 
> 		max_scan--;
> 
> max_scan-- should happen only after the memclass
> check to ensure not
> failing too early on GFP_KERNEL/DMA allocations
> (i.e. no highmem)
> 
> This is the right fix:
> 
> --- 2.4.23pre4/mm/vmscan.c.~1~	2003-09-13
> 00:08:04.000000000 +0200
> +++ 2.4.23pre4/mm/vmscan.c	2003-09-21
> 04:40:12.000000000 +0200
> @@ -401,6 +401,8 @@ static int shrink_cache(int
> nr_pages, zo
>  		if (!memclass(page_zone(page), classzone))
>  			continue;
>  
> +		max_scan--;
> +
>  		/* Racy check to avoid trylocking when not
> worthwhile */
>  		if (!page->buffers && (page_count(page) != 1 ||
> !page->mapping))
>  			goto page_mapped;
> 
> so your fix is slightly wrong in non-highmem terms
> (also for scheduling
> terms, you would decrease it even when there's a
> schedule). We need to
> finish the merge ASAP with Marcelo. I didn't send
> specific patches to
> Marcelo myself yet, I only pointed out the url and
> list of them plus
> I described the details he wanted to know. I
> understand he merged what
> he found most interesting so I didn't notice this
> half merge problem yet
> but I will start looking into this with the highest
> prio on Monday (I
> was going to look into pre4 very soon for -aa that
> now will reject
> bigtime, and the watermarks too but I had some
> trouble with the ram and
> the scheduler in my fast amd64 this week that kept
> me busy, the
> scheduler fix will be in next -aa and improves ppc
> as well 11%, on some
> of my workloads it's a 99% improvement [this isn't
> relevant for mainline
> though and apparently it was already fixed in 2.6]
> ;).
> 
> > 2. The second part of the patch makes sure that
> > inode/dentry caches are shrunk at least once every
> 5
> > secs.  On a machine with a heavy inode
> stat/directory
> > lookup load (e.g. NFS server), most of the memory
> > winds up sitting idle in unused inodes/dentry. 
> The
> > present code only reclaims these when a swap_out()
> > happens or shrink_caches() fails.  This can take a
> > while on a machine will very few mapped pages such
> as
> > an NFS server.
> 
> For lots of workloads this will nuke dcache way too
> fast and rebuilding
> it with the fs and buffercache is costly.  However
> if you make the delay
> a sysctl set to MAX_SCHEDULE_TIMEOUT, I would be
> definitely fine in
> merging it. That way it won't make any difference by
> default and it can
> help in the corner cases where hacks like this may
> provide benefits as
> you noted.
> 
> thanks!
> 
> Andrea - If you prefer relying on open source
> software, check these links:
> 	   
>
rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
> 	    http://www.cobite.com/cvsps/
> 	    svn://svn.kernel.org/linux-2.[46]/trunk

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
--0-1163173720-1064122329=:44957
Content-Type: application/octet-stream; name="vfs-interval.patch"
Content-Transfer-Encoding: base64
Content-Description: vfs-interval.patch
Content-Disposition: attachment; filename="vfs-interval.patch"

LS0tIC4va2VybmVsL3N5c2N0bC5jLn4xfgkyMDAzLTA5LTE2IDIwOjQ0OjE0
LjAwMDAwMDAwMCAtMDQwMAorKysgLi9rZXJuZWwvc3lzY3RsLmMJMjAwMy0w
OS0yMSAwMDo0OTozMi4wMDAwMDAwMDAgLTA0MDAKQEAgLTI4MSw2ICsyODEs
OCBAQAogCSAmdm1fZ2ZwX2RlYnVnLCBzaXplb2YoaW50KSwgMDY0NCwgTlVM
TCwgJnByb2NfZG9pbnR2ZWN9LAogCXtWTV9WRlNfU0NBTl9SQVRJTywgInZt
X3Zmc19zY2FuX3JhdGlvIiwgCiAJICZ2bV92ZnNfc2Nhbl9yYXRpbywgc2l6
ZW9mKGludCksIDA2NDQsIE5VTEwsICZwcm9jX2RvaW50dmVjfSwKKwl7Vk1f
VkZTX1NDQU5fSU5URVJWQUwsICJ2bV92ZnNfc2Nhbl9pbnRlcnZhbCIsIAor
CSAmdm1fdmZzX3NjYW5faW50ZXJ2YWwsIHNpemVvZihpbnQpLCAwNjQ0LCBO
VUxMLCAmcHJvY19kb2ludHZlY30sCiAJe1ZNX0NBQ0hFX1NDQU5fUkFUSU8s
ICJ2bV9jYWNoZV9zY2FuX3JhdGlvIiwgCiAJICZ2bV9jYWNoZV9zY2FuX3Jh
dGlvLCBzaXplb2YoaW50KSwgMDY0NCwgTlVMTCwgJnByb2NfZG9pbnR2ZWN9
LAogCXtWTV9NQVBQRURfUkFUSU8sICJ2bV9tYXBwZWRfcmF0aW8iLCAKLS0t
IC4vbW0vdm1zY2FuLmMufjF+CTIwMDMtMDktMTYgMjA6NDQ6MTQuMDAwMDAw
MDAwIC0wNDAwCisrKyAuL21tL3Ztc2Nhbi5jCTIwMDMtMDktMjEgMDA6NTk6
MTEuMDAwMDAwMDAwIC0wNDAwCkBAIC02NSw2ICs2NSwxMiBAQAogaW50IHZt
X3Zmc19zY2FuX3JhdGlvID0gNjsKIAogLyoKKyAqICJ2bV92ZnNfc2Nhbl9p
bnRlcnZhbCIgaXMgaG93IG9mdGVuIChpbiBzZWNvbmRzKQorICogbWVtb3J5
IGdldHMgcmVjbGFpbWVkIGZyb20gaW5vZGUvZGVudHJ5IGNhY2hlLgorICov
CitpbnQgdm1fdmZzX3NjYW5faW50ZXJ2YWwgPSBNQVhfU0NIRURVTEVfVElN
RU9VVCAvIEhaOworCisvKgogICogVGhlIHN3YXAtb3V0IGZ1bmN0aW9uIHJl
dHVybnMgMSBpZiBpdCBzdWNjZXNzZnVsbHkKICAqIHNjYW5uZWQgYWxsIHRo
ZSBwYWdlcyBpdCB3YXMgYXNrZWQgdG8gKGBjb3VudCcpLgogICogSXQgcmV0
dXJucyB6ZXJvIGlmIGl0IGNvdWxkbid0IGRvIGFueXRoaW5nLApAQCAtMzY0
LDYgKzM3MCwyMCBAQAogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBz
aHJpbmtfdmZzX2NhY2hlcyhpbnQgZm9yY2UsIHVuc2lnbmVkIGludCBnZnBf
bWFzaykKK3sKKwlzdGF0aWMgdW5zaWduZWQgbG9uZyBsYXN0X3NjYW4gPSAw
OworCisJaWYgKGZvcmNlIHx8IHRpbWVfYWZ0ZXIoamlmZmllcywgbGFzdF9z
Y2FuICsgdm1fdmZzX3NjYW5faW50ZXJ2YWwgKiBIWikpIHsKKwkJc2hyaW5r
X2RjYWNoZV9tZW1vcnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9tYXNrKTsK
KwkJc2hyaW5rX2ljYWNoZV9tZW1vcnkodm1fdmZzX3NjYW5fcmF0aW8sIGdm
cF9tYXNrKTsKKyNpZmRlZiBDT05GSUdfUVVPVEEKKwkJc2hyaW5rX2RxY2Fj
aGVfbWVtb3J5KHZtX3Zmc19zY2FuX3JhdGlvLCBnZnBfbWFzayk7CisjZW5k
aWYKKwkJbGFzdF9zY2FuID0gamlmZmllczsKKwl9Cit9CisKIHN0YXRpYyB2
b2lkIEZBU1RDQUxMKHJlZmlsbF9pbmFjdGl2ZShpbnQgbnJfcGFnZXMsIHpv
bmVfdCAqIGNsYXNzem9uZSkpOwogc3RhdGljIGludCBGQVNUQ0FMTChzaHJp
bmtfY2FjaGUoaW50IG5yX3BhZ2VzLCB6b25lX3QgKiBjbGFzc3pvbmUsIHVu
c2lnbmVkIGludCBnZnBfbWFzaywgaW50ICogZmFpbGVkX3N3YXBvdXQpKTsK
IHN0YXRpYyBpbnQgc2hyaW5rX2NhY2hlKGludCBucl9wYWdlcywgem9uZV90
ICogY2xhc3N6b25lLCB1bnNpZ25lZCBpbnQgZ2ZwX21hc2ssIGludCAqIGZh
aWxlZF9zd2Fwb3V0KQpAQCAtNDAxLDYgKzQyMSw4IEBACiAJCWlmICghbWVt
Y2xhc3MocGFnZV96b25lKHBhZ2UpLCBjbGFzc3pvbmUpKQogCQkJY29udGlu
dWU7CiAKKwkJbWF4X3NjYW4tLTsKKwogCQkvKiBSYWN5IGNoZWNrIHRvIGF2
b2lkIHRyeWxvY2tpbmcgd2hlbiBub3Qgd29ydGh3aGlsZSAqLwogCQlpZiAo
IXBhZ2UtPmJ1ZmZlcnMgJiYgKHBhZ2VfY291bnQocGFnZSkgIT0gMSB8fCAh
cGFnZS0+bWFwcGluZykpCiAJCQlnb3RvIHBhZ2VfbWFwcGVkOwpAQCAtNTE2
LDExICs1MzgsNyBAQAogCQkJCWlmIChucl9wYWdlcyA8PSAwKQogCQkJCQln
b3RvIG91dDsKIAotCQkJCXNocmlua19kY2FjaGVfbWVtb3J5KHZtX3Zmc19z
Y2FuX3JhdGlvLCBnZnBfbWFzayk7Ci0JCQkJc2hyaW5rX2ljYWNoZV9tZW1v
cnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9tYXNrKTsKLSNpZmRlZiBDT05G
SUdfUVVPVEEKLQkJCQlzaHJpbmtfZHFjYWNoZV9tZW1vcnkodm1fdmZzX3Nj
YW5fcmF0aW8sIGdmcF9tYXNrKTsKLSNlbmRpZgorCQkJCXNocmlua192ZnNf
Y2FjaGVzKCpmYWlsZWRfc3dhcG91dCwgZ2ZwX21hc2spOwogCiAJCQkJaWYg
KCEqZmFpbGVkX3N3YXBvdXQpCiAJCQkJCSpmYWlsZWRfc3dhcG91dCA9ICFz
d2FwX291dChjbGFzc3pvbmUpOwpAQCAtNjE0LDYgKzYzMiw4IEBACiAJaWYg
KG5yX3BhZ2VzIDw9IDApCiAJCWdvdG8gb3V0OwogCisJc2hyaW5rX3Zmc19j
YWNoZXMoMCwgZ2ZwX21hc2spOworCiAJc3Bpbl9sb2NrKCZwYWdlbWFwX2xy
dV9sb2NrKTsKIAlyZWZpbGxfaW5hY3RpdmUobnJfcGFnZXMsIGNsYXNzem9u
ZSk7CiAKQEAgLTYzOCwxMSArNjU4LDkgQEAKIAkJCW5yX3BhZ2VzID0gc2hy
aW5rX2NhY2hlcyhjbGFzc3pvbmUsIGdmcF9tYXNrLCBucl9wYWdlcywgJmZh
aWxlZF9zd2Fwb3V0KTsKIAkJCWlmIChucl9wYWdlcyA8PSAwKQogCQkJCXJl
dHVybiAxOwotCQkJc2hyaW5rX2RjYWNoZV9tZW1vcnkodm1fdmZzX3NjYW5f
cmF0aW8sIGdmcF9tYXNrKTsKLQkJCXNocmlua19pY2FjaGVfbWVtb3J5KHZt
X3Zmc19zY2FuX3JhdGlvLCBnZnBfbWFzayk7Ci0jaWZkZWYgQ09ORklHX1FV
T1RBCi0JCQlzaHJpbmtfZHFjYWNoZV9tZW1vcnkodm1fdmZzX3NjYW5fcmF0
aW8sIGdmcF9tYXNrKTsKLSNlbmRpZgorCisJCQlzaHJpbmtfdmZzX2NhY2hl
cygxLCBnZnBfbWFzayk7CisKIAkJCWlmICghZmFpbGVkX3N3YXBvdXQpCiAJ
CQkJZmFpbGVkX3N3YXBvdXQgPSAhc3dhcF9vdXQoY2xhc3N6b25lKTsKIAkJ
fSB3aGlsZSAoLS10cmllcyk7Ci0tLSAuL2luY2x1ZGUvbGludXgvc3dhcC5o
Ln4xfgkyMDAzLTA5LTE2IDIwOjQ2OjM1LjAwMDAwMDAwMCAtMDQwMAorKysg
Li9pbmNsdWRlL2xpbnV4L3N3YXAuaAkyMDAzLTA5LTIxIDAwOjU2OjIzLjAw
MDAwMDAwMCAtMDQwMApAQCAtMTE2LDYgKzExNiw3IEBACiBleHRlcm4gaW50
IEZBU1RDQUxMKHRyeV90b19mcmVlX3BhZ2VzX3pvbmUoem9uZV90ICosIHVu
c2lnbmVkIGludCkpOwogZXh0ZXJuIGludCBGQVNUQ0FMTCh0cnlfdG9fZnJl
ZV9wYWdlcyh1bnNpZ25lZCBpbnQpKTsKIGV4dGVybiBpbnQgdm1fdmZzX3Nj
YW5fcmF0aW8sIHZtX2NhY2hlX3NjYW5fcmF0aW8sIHZtX2xydV9iYWxhbmNl
X3JhdGlvLCB2bV9wYXNzZXMsIHZtX2dmcF9kZWJ1Zywgdm1fbWFwcGVkX3Jh
dGlvOworZXh0ZXJuIGludCB2bV92ZnNfc2Nhbl9pbnRlcnZhbDsKIAogLyog
bGludXgvbW0vcGFnZV9pby5jICovCiBleHRlcm4gdm9pZCByd19zd2FwX3Bh
Z2UoaW50LCBzdHJ1Y3QgcGFnZSAqKTsKLS0tIC4vaW5jbHVkZS9saW51eC9z
eXNjdGwuaC5+MX4JMjAwMy0wOS0xNiAyMDo0NjozNS4wMDAwMDAwMDAgLTA0
MDAKKysrIC4vaW5jbHVkZS9saW51eC9zeXNjdGwuaAkyMDAzLTA5LTIxIDAw
OjU5OjM3LjAwMDAwMDAwMCAtMDQwMApAQCAtMTU0LDYgKzE1NCw3IEBACiAJ
Vk1fR0ZQX0RFQlVHPTE4LCAgICAgICAgLyogZGVidWcgR0ZQIGZhaWx1cmVz
ICovCiAJVk1fQ0FDSEVfU0NBTl9SQVRJTz0xOSwgLyogcGFydCBvZiB0aGUg
aW5hY3RpdmUgY2FjaGUgbGlzdCB0byBzY2FuICovCiAJVk1fTUFQUEVEX1JB
VElPPTIwLCAgICAgLyogYW1vdW50IG9mIHVuZnJlZWFibGUgcGFnZXMgdGhh
dCB0cmlnZ2VycyBzd2Fwb3V0ICovCisJVk1fVkZTX1NDQU5fSU5URVJWQUw9
MjEsLyogaW50ZXJ2YWwgKGluIHNlY3MpIGJldHdlZW4gcmVjbGFpbWluZyBt
ZW1vcnkgZnJvbSBpbm9kZS9kZW50cnkgY2FjaGUgKi8KIH07CiAKIAo=

--0-1163173720-1064122329=:44957--
