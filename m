Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWCFTca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWCFTca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWCFTca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:32:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750878AbWCFTc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:32:29 -0500
Date: Mon, 6 Mar 2006 11:32:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <200603061943.35502.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com>
 <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org> <200603061943.35502.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2108479697-1141673529=:13139"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2108479697-1141673529=:13139
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Mon, 6 Mar 2006, Jesper Juhl wrote:
>
> Not a git user (I need to become one but haven't found the time to read up 
> on it yet), but no problem, I'll dig out the patch and try reverting it.

It's attached here.

NOTE! I'm not at all sure it's the re-try logic. It could be something 
else. Anything that completes the request before it's actually totally 
done - or possibly re-uses the sense data for something else would be 
wrong and buggy.

> Btw, the messages turn out slightly different on each boot, here are the 
> ones from this current boot of my box:
> 
> Slab corruption: start=f72b6b98, len=64
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Ok, same deal. "Medium not present - tray closed" sense data.

> Slab corruption: start=f72b6b98, len=64
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Hmm. Totally empty sense data? Strange.

> Slab corruption: start=f72b6b98, len=64
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c01d3769>](ext3_clear_inode+0x29/0x40)
> 000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
> 010: 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

This is different. But it looks similar. It looks like the thing was 
actually re-allocated for something else (posix acl data?) but then 
overwritten. However, the overwritten data does look like SCSI sense 
information again ("Invalid field in cdb"), so I think it's the same 
thing despite the fact that it had gotten re-allocated for something else.

> Would gathering more of these help you out?

It's always interesting when trying to find the pattern, but I think the 
pattern is already pretty clear. sr_do_ioctl() seems to be the thing, and 
sense data is written too late.

> I have no USB, SATA or similar devices in the box, only a floppy drive, a 
> SCSI harddisk, a SCSI CD writer and a SCSI DVD-ROM.

Well, the fact that you have a CDSI CD-writer and a SCSI DVD-ROM explains 
the thing, so that's all good.

> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
>         <Adaptec 29160N Ultra160 SCSI adapter>
>         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

So it's either an aic7xxx bug, or it's generic SCSI.

Considering that we've had other slab corruption issues (the reason I was 
looking closely at yours), generic SCSI isn't out of the question.

If you were a git user, doing a bisection run would be useful since you 
seem to be able to recreate it at will. Oh, well. Testign that one patch 
would still help.

		Linus
--21872808-2108479697-1141673529=:13139
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0603061132090.13139@g5.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=diff

ZGlmZi10cmVlIDE3ZTAxZjIxNmI2MTFmYzQ2OTU2ZGNkOTA2M2FlYzRkZTc1
OTkxZTMgKGZyb20gNmU2OGFmNjY2ZjUzMzYyNTRiNTcxNWRjYTU5MTAyNmI3
MzI0NDk5YSkNCkF1dGhvcjogTWlrZSBDaHJpc3RpZSA8bWljaGFlbGNAY3Mu
d2lzYy5lZHU+DQpEYXRlOiAgIEZyaSBOb3YgMTEgMDU6MzE6MzcgMjAwNSAt
MDYwMA0KDQogICAgW1NDU0ldIGFkZCByZXRyaWVzIGZpZWxkIHRvIHJlcXVl
c3QgZm9yIFJFUV9CTE9DS19QQyB1c2UNCiAgICANCiAgICBGb3IgdGFwZSB3
ZSBuZWVkIHRvIGNvbnRyb2wgdGhlIHJldHJpZXMuIFRoaXMgcGF0Y2ggYWRk
cyBhIHJldHJpZXMNCiAgICBjb3VudGVyIG9uIHRoZSByZXF1ZXN0IGZvciBS
RVFfQkxPQ0tfUEMgY29tbWFuZHMgb3JpZ2luYXRpbmcgZnJvbQ0KICAgIHNj
c2lfZXhlY3V0ZSogdG8gdXNlLiBSRVFfQkxPQ0tfUEMgY29tbWFuZHMgY29t
bWluZyBmcm9tIHRoZSBibG9jaw0KICAgIGxheWVyIFNHX0lPIHBhdGggY29u
dGludWUgdG8gdXNlIHRoZSByZXRpcmVzIHNldCBpbiB0aGUgVUxEIGluaXRf
Y29tbWFuZC4NCiAgICAoc2NzaV9leGVjdXRlKiBkb2VzIG5vdCBzZXQgdGhl
IGdlbmRpc2sgc28gd2UgZG8gbm90IGV4ZWN1dGUNCiAgICB0aGUgaW5pdF9j
b21tYW5kIGluIHRoYXQgcGF0aCkuDQogICAgDQogICAgU2lnbmVkLW9mZi1i
eTogTWlrZSBDaHJpc3RpZSA8bWljaGFlbGNAY3Mud2lzYy5lZHU+DQogICAg
U2lnbmVkLW9mZi1ieTogSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21s
ZXlAU3RlZWxFeWUuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L3Njc2lfbGliLmMgYi9kcml2ZXJzL3Njc2kvc2NzaV9saWIuYw0KaW5kZXgg
ZWIwY2ZiZi4uMzY1ODQzYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS9z
Y3NpX2xpYi5jDQorKysgYi9kcml2ZXJzL3Njc2kvc2NzaV9saWIuYw0KQEAg
LTI1OSw2ICsyNTksNyBAQCBpbnQgc2NzaV9leGVjdXRlKHN0cnVjdCBzY3Np
X2RldmljZSAqc2RlDQogCW1lbWNweShyZXEtPmNtZCwgY21kLCByZXEtPmNt
ZF9sZW4pOw0KIAlyZXEtPnNlbnNlID0gc2Vuc2U7DQogCXJlcS0+c2Vuc2Vf
bGVuID0gMDsNCisJcmVxLT5yZXRyaWVzID0gcmV0cmllczsNCiAJcmVxLT50
aW1lb3V0ID0gdGltZW91dDsNCiAJcmVxLT5mbGFncyB8PSBmbGFncyB8IFJF
UV9CTE9DS19QQyB8IFJFUV9TUEVDSUFMIHwgUkVRX1FVSUVUOw0KIA0KQEAg
LTQ3Miw2ICs0NzMsNyBAQCBpbnQgc2NzaV9leGVjdXRlX2FzeW5jKHN0cnVj
dCBzY3NpX2RldmljDQogCXJlcS0+c2Vuc2UgPSBzaW9jLT5zZW5zZTsNCiAJ
cmVxLT5zZW5zZV9sZW4gPSAwOw0KIAlyZXEtPnRpbWVvdXQgPSB0aW1lb3V0
Ow0KKwlyZXEtPnJldHJpZXMgPSByZXRyaWVzOw0KIAlyZXEtPmZsYWdzIHw9
IFJFUV9CTE9DS19QQyB8IFJFUV9RVUlFVDsNCiAJcmVxLT5lbmRfaW9fZGF0
YSA9IHNpb2M7DQogDQpAQCAtMTM5Myw3ICsxMzk1LDcgQEAgc3RhdGljIGlu
dCBzY3NpX3ByZXBfZm4oc3RydWN0IHJlcXVlc3RfcQ0KIAkJCQljbWQtPnNj
X2RhdGFfZGlyZWN0aW9uID0gRE1BX05PTkU7DQogCQkJDQogCQkJY21kLT50
cmFuc2ZlcnNpemUgPSByZXEtPmRhdGFfbGVuOw0KLQkJCWNtZC0+YWxsb3dl
ZCA9IDM7DQorCQkJY21kLT5hbGxvd2VkID0gcmVxLT5yZXRyaWVzOw0KIAkJ
CWNtZC0+dGltZW91dF9wZXJfY29tbWFuZCA9IHJlcS0+dGltZW91dDsNCiAJ
CQljbWQtPmRvbmUgPSBzY3NpX2dlbmVyaWNfZG9uZTsNCiAJCX0NCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51
eC9ibGtkZXYuaA0KaW5kZXggOWE2ODcxNi4uNTA5ZTlhMCAxMDA2NDQNCi0t
LSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvYmxrZGV2LmgNCkBAIC0xODQsNiArMTg0LDcgQEAgc3RydWN0IHJlcXVl
c3Qgew0KIAl2b2lkICpzZW5zZTsNCiANCiAJdW5zaWduZWQgaW50IHRpbWVv
dXQ7DQorCWludCByZXRyaWVzOw0KIA0KIAkvKg0KIAkgKiBGb3IgUG93ZXIg
TWFuYWdlbWVudCByZXF1ZXN0cw0K

--21872808-2108479697-1141673529=:13139--
