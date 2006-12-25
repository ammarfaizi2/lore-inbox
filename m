Return-Path: <linux-kernel-owner+w=401wt.eu-S1753302AbWLYA1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbWLYA1H (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbWLYA1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 19:27:07 -0500
Received: from c-68-85-149-9.hsd1.mi.comcast.net ([68.85.149.9]:53735 "EHLO
	paragw.zapto.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbWLYA1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 19:27:06 -0500
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 19:27:06 EST
Date: Sun, 24 Dec 2006 19:15:55 -0500 (EST)
From: Parag Warudkar <paragw@paragw.zapto.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: selinux networking: sleeping functin called from invalid context
 in 2.6.20-rc[12]
In-Reply-To: <20061225052124.A10323@freya>
Message-ID: <Pine.LNX.4.64.0612241856300.29007@paragw.zapto.org>
References: <20061225052124.A10323@freya>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1430522261-1707996492-1167005755=:29007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1430522261-1707996492-1167005755=:29007
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Mon, 25 Dec 2006, Adam J. Richter wrote:

> 	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
> for several network programs running on my system:
>
> [  156.381868] BUG: sleeping function called from invalid context at net/core/sock.c:1523
> [  156.381876] in_atomic():1, irqs_disabled():0
> [  156.381881] no locks held by kio_http/9693.
> [  156.381886]  [<c01057a2>] show_trace_log_lvl+0x1a/0x2f
> [  156.381900]  [<c0105dab>] show_trace+0x12/0x14
> [  156.381908]  [<c0105e48>] dump_stack+0x16/0x18
> [  156.381917]  [<c011e30f>] __might_sleep+0xe5/0xeb
> [  156.381926]  [<c025942a>] lock_sock_nested+0x1d/0xc4
> [  156.381937]  [<c01cc570>] selinux_netlbl_inode_permission+0x5a/0x8e
> [  156.381946]  [<c01c2505>] selinux_file_permission+0x96/0x9b
> [  156.381954]  [<c0175a0a>] vfs_write+0x8d/0x167
> [  156.381962]  [<c017605a>] sys_write+0x3f/0x63
> [  156.381971]  [<c01040c0>] syscall_call+0x7/0xb
> [  156.381980]  =======================
>

lock_sock_nested can sleep, its BH counterpart doesn't.
selinux_netlbl_inode_permission() probably needs to use the BH counterpart 
unconditionally. But I am not sure if that function is always called from an atomic context. Assuming it is, the 
attached patch should fix this.

Compile tested.

Signed-off-by: Parag Warudkar <paragw@paragw.zapto.org>

Parag

--1430522261-1707996492-1167005755=:29007
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=services.c.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0612241915550.29007@paragw.zapto.org>
Content-Description: selinux - use proper locking interfaces
Content-Disposition: attachment; filename=services.c.patch

LS0tIGxpbnV4LTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMu
b3JpZwkyMDA2LTEyLTI0IDE4OjUyOjQyLjAwMDAwMDAwMCAtMDUwMA0KKysr
IGxpbnV4LTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMJMjAw
Ni0xMi0yNCAxOTowMDoyMi4wMDAwMDAwMDAgLTA1MDANCkBAIC0yNjYwLDkg
KzI2NjAsOSBAQA0KIAkJcmN1X3JlYWRfdW5sb2NrKCk7DQogCQlyZXR1cm4g
MDsNCiAJfQ0KLQlsb2NrX3NvY2soc29jay0+c2spOw0KKwliaF9sb2NrX3Nv
Y2tfbmVzdGVkKHNvY2stPnNrKTsNCiAJcmMgPSBzZWxpbnV4X25ldGxibF9z
b2NrZXRfc2V0c2lkKHNvY2ssIHNrc2VjLT5zaWQpOw0KLQlyZWxlYXNlX3Nv
Y2soc29jay0+c2spOw0KKwliaF91bmxvY2tfc29jayhzb2NrLT5zayk7DQog
CXJjdV9yZWFkX3VubG9jaygpOw0KIA0KIAlyZXR1cm4gcmM7DQo=

--1430522261-1707996492-1167005755=:29007--
