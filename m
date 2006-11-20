Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934198AbWKTOdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934198AbWKTOdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934199AbWKTOdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:33:17 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:63441 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S934198AbWKTOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:33:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=d5/5yCeVOeNmez32frwc8RlPd44Oux/RgieZrM1PekL3cgIES9r4p8yNL7c6IZE+FyVD3Vfn3RBN4aXHmQ7lCpqu9/RZk6Scw6Xn37IsoJx/Ct3ngxpXKkbS5JFfQVLxjW2PLr/TbMB1Lh5+hDIXGucccTQ4YcOW2xtoa6qz3vw=
Message-ID: <9a8748490611200632n3b545698h295631460a212b9b@mail.gmail.com>
Date: Mon, 20 Nov 2006 15:32:43 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed mount
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <9a8748490611161418l4d5a773k76cf7061d73c8a51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2046_28541952.1164033163623"
References: <200611162218.26945.jesper.juhl@gmail.com>
	 <20061116220958.GE11034@melbourne.sgi.com>
	 <9a8748490611161418l4d5a773k76cf7061d73c8a51@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2046_28541952.1164033163623
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 16/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 16/11/06, David Chinner <dgc@sgi.com> wrote:
> > On Thu, Nov 16, 2006 at 10:18:26PM +0100, Jesper Juhl wrote:
> > > (got no reply on this when I originally send it on 20061031, so resending
> > >  now that a bit of time has passed.  The patch still applies cleanly to
> > >  Linus' git tree as of today.)
> > >
> > >
> > > The Coverity checker spotted a potential problem in XFS.
> > >
> > > The problem is that if, in xfs_mount(), this code triggers:
> > >
> > >       ...
> > >       if (!mp->m_logdev_targp)
> > >               goto error0;
> > >       ...
> > >
> > > Then we'll end up calling xfs_unmountfs_close() with a NULL
> > > 'mp->m_logdev_targp'.
> > > This in turn will result in a call to xfs_free_buftarg() with its 'btp'
> > > argument == NULL. xfs_free_buftarg() dereferences 'btp' leading to
> > > a NULL pointer dereference and crash.
> >
> > Interesting that coverity found that, but failed to find the other
> > leaks in that function from exactly the same code and error
> > case.....
> >
> > > I think this can happen, since the fatal call to xfs_free_buftarg()
> > > happens when 'm_logdev_targp != m_ddev_targp' and due to a check of
> > > 'm_ddev_targp' against NULL in xfs_mount() (and subsequent return if it is
> > > NULL) the two will never both be NULL when we hit the error0 label from
> > > the two lines cited above.
> > >
> > > Comments welcome (please keep me on Cc: on replies).
> > >
> > > Here's a proposed patch to fix this by testing 'btp' against NULL in
> > > xfs_free_buftarg().
> >
> > Not the right fix - we should only be trying to free valid
> > buftargs, which means xfs_unmountfs_close() is the correct
> > place to fix this....
> >
>
> Ok.
>
> > e.g:
> >
> > -       if (mp->m_logdev_targp != mp->m_ddev_targp)
> > +       if (mp->m_logdev_targp && (mp->m_logdev_targp != mp->m_ddev_targp))
> >
> > As to the afore-mentioned leaks, if we fail to allocate a realtime
> > buftarg, then we will leak a reference to both the rtdev and logdev,
> > and if we fail to allocate an external log buftarg we'll leak a
> > reference to the logdev. i.e., we fail to do one or both of:
> >
> >         xfs_blkdev_put(logdev);
> >         xfs_blkdev_put(rtdev);
> >
> > To remove the bdev references we may have gained earlier. Normally,
> > these references are released by xfs_free_buftarg(), but because we
> > failed to allocate the buftarg, we can't drop the references via
> > that method....
> >
>

How about something like the attached patch ?

(sorry about the attachment, but I can't inline the patch from my
current location - a whitespace damaged version is below though for
easy review)



Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/xfs_mount.c  |    2 +-
 fs/xfs/xfs_vfsops.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 9dfae18..3497128 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1135,7 +1135,7 @@ #endif
 void
 xfs_unmountfs_close(xfs_mount_t *mp, struct cred *cr)
 {
-       if (mp->m_logdev_targp != mp->m_ddev_targp)
+       if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
                xfs_free_buftarg(mp->m_logdev_targp, 1);
        if (mp->m_rtdev_targp)
                xfs_free_buftarg(mp->m_rtdev_targp, 1);
diff --git a/fs/xfs/xfs_vfsops.c b/fs/xfs/xfs_vfsops.c
index 62336a4..6d7e8f1 100644
--- a/fs/xfs/xfs_vfsops.c
+++ b/fs/xfs/xfs_vfsops.c
@@ -473,13 +473,19 @@ xfs_mount(
        }
        if (rtdev) {
                mp->m_rtdev_targp = xfs_alloc_buftarg(rtdev, 1);
-               if (!mp->m_rtdev_targp)
+               if (!mp->m_rtdev_targp) {
+                       xfs_blkdev_put(logdev);
+                       xfs_blkdev_put(rtdev);
                        goto error0;
+               }
        }
        mp->m_logdev_targp = (logdev && logdev != ddev) ?
                                xfs_alloc_buftarg(logdev, 1) : mp->m_ddev_targp;
-       if (!mp->m_logdev_targp)
+       if (!mp->m_logdev_targp) {
+               xfs_blkdev_put(logdev);
+               xfs_blkdev_put(rtdev);
                goto error0;
+       }

        /*
         * Setup flags based on mount(2) options and then the superblock


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_2046_28541952.1164033163623
Content-Type: text/plain; name="patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.txt"
X-Attachment-Id: f_euqza2rt

ClNpZ25lZC1vZmYtYnk6IEplc3BlciBKdWhsIDxqZXNwZXIuanVobEBnbWFpbC5jb20+Ci0tLQoK
IGZzL3hmcy94ZnNfbW91bnQuYyAgfCAgICAyICstCiBmcy94ZnMveGZzX3Zmc29wcy5jIHwgICAx
MCArKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy94ZnMveGZzX21vdW50LmMgYi9mcy94ZnMveGZzX21vdW50
LmMKaW5kZXggOWRmYWUxOC4uMzQ5NzEyOCAxMDA2NDQKLS0tIGEvZnMveGZzL3hmc19tb3VudC5j
CisrKyBiL2ZzL3hmcy94ZnNfbW91bnQuYwpAQCAtMTEzNSw3ICsxMTM1LDcgQEAgI2VuZGlmCiB2
b2lkCiB4ZnNfdW5tb3VudGZzX2Nsb3NlKHhmc19tb3VudF90ICptcCwgc3RydWN0IGNyZWQgKmNy
KQogewotCWlmIChtcC0+bV9sb2dkZXZfdGFyZ3AgIT0gbXAtPm1fZGRldl90YXJncCkKKwlpZiAo
bXAtPm1fbG9nZGV2X3RhcmdwICYmIG1wLT5tX2xvZ2Rldl90YXJncCAhPSBtcC0+bV9kZGV2X3Rh
cmdwKQogCQl4ZnNfZnJlZV9idWZ0YXJnKG1wLT5tX2xvZ2Rldl90YXJncCwgMSk7CiAJaWYgKG1w
LT5tX3J0ZGV2X3RhcmdwKQogCQl4ZnNfZnJlZV9idWZ0YXJnKG1wLT5tX3J0ZGV2X3RhcmdwLCAx
KTsKZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfdmZzb3BzLmMgYi9mcy94ZnMveGZzX3Zmc29wcy5j
CmluZGV4IDYyMzM2YTQuLjZkN2U4ZjEgMTAwNjQ0Ci0tLSBhL2ZzL3hmcy94ZnNfdmZzb3BzLmMK
KysrIGIvZnMveGZzL3hmc192ZnNvcHMuYwpAQCAtNDczLDEzICs0NzMsMTkgQEAgeGZzX21vdW50
KAogCX0KIAlpZiAocnRkZXYpIHsKIAkJbXAtPm1fcnRkZXZfdGFyZ3AgPSB4ZnNfYWxsb2NfYnVm
dGFyZyhydGRldiwgMSk7Ci0JCWlmICghbXAtPm1fcnRkZXZfdGFyZ3ApCisJCWlmICghbXAtPm1f
cnRkZXZfdGFyZ3ApIHsKKwkJCXhmc19ibGtkZXZfcHV0KGxvZ2Rldik7CisJCQl4ZnNfYmxrZGV2
X3B1dChydGRldik7CiAJCQlnb3RvIGVycm9yMDsKKwkJfQogCX0KIAltcC0+bV9sb2dkZXZfdGFy
Z3AgPSAobG9nZGV2ICYmIGxvZ2RldiAhPSBkZGV2KSA/CiAJCQkJeGZzX2FsbG9jX2J1ZnRhcmco
bG9nZGV2LCAxKSA6IG1wLT5tX2RkZXZfdGFyZ3A7Ci0JaWYgKCFtcC0+bV9sb2dkZXZfdGFyZ3Ap
CisJaWYgKCFtcC0+bV9sb2dkZXZfdGFyZ3ApIHsKKwkJeGZzX2Jsa2Rldl9wdXQobG9nZGV2KTsK
KwkJeGZzX2Jsa2Rldl9wdXQocnRkZXYpOwogCQlnb3RvIGVycm9yMDsKKwl9CiAKIAkvKgogCSAq
IFNldHVwIGZsYWdzIGJhc2VkIG9uIG1vdW50KDIpIG9wdGlvbnMgYW5kIHRoZW4gdGhlIHN1cGVy
YmxvY2sK
------=_Part_2046_28541952.1164033163623--
