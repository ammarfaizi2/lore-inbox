Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968332AbWLEEYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968332AbWLEEYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968333AbWLEEYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:24:37 -0500
Received: from ns.suse.de ([195.135.220.2]:57809 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968332AbWLEEYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:24:36 -0500
From: Neil Brown <neilb@suse.de>
To: Olaf Titz <olaf@bigred.inka.de>
Date: Tue, 5 Dec 2006 15:24:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17780.62607.544405.181452@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
In-Reply-To: message from Olaf Titz on Monday December 4
References: <E1GrJH9-0003Hr-00@bigred.inka.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 4, olaf@bigred.inka.de wrote:
> This is 100% reproducible. It hangs exportfs on shutdown.
> 
> Dec  4 19:50:13 glotze kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000040
> Dec  4 19:50:13 glotze kernel:  printing eip:
> Dec  4 19:50:13 glotze kernel: c017254a
> Dec  4 19:50:13 glotze kernel: *pde = 00000000
> Dec  4 19:50:13 glotze kernel: Oops: 0000 [#1]
> Dec  4 19:50:13 glotze kernel: PREEMPT 
> Dec  4 19:50:13 glotze kernel: Modules linked in: nfsd exportfs i915 stv0299 budget_ci budget_core dvb_core saa7146 ttpci_eeprom 8250 serial_core nfs lockd sunrpc tuner tvaudio bttv video_buf ir_common compat_ioctl32 i2c_algo_bit btcx_risc tveeprom i2c_core videodev v4l1_compat v4l2_common ipv6 nvram snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ide_cd cdrom e100 mii af_packet
> Dec  4 19:50:13 glotze kernel: CPU:    0
> Dec  4 19:50:13 glotze kernel: EIP:    0060:[seq_escape+29/201]    Not tainted VLI
> Dec  4 19:50:13 glotze kernel: EFLAGS: 00010286   (2.6.19 #2)
> Dec  4 19:50:13 glotze kernel: EIP is at seq_escape+0x1d/0xc9
> Dec  4 19:50:13 glotze kernel: eax: c7610000   ebx: c7370e00   ecx: 00001000   edx: c761005c
> Dec  4 19:50:13 glotze kernel: esi: 00000040   edi: d0590384   ebp: cd2115f4   esp: c9543ef4
> Dec  4 19:50:13 glotze kernel: ds: 007b   es: 007b   ss: 0068
> Dec  4 19:50:13 glotze kernel: Process cat (pid: 1379, ti=c9542000 task=c73ea030 task.ti=c9542000)
> Dec  4 19:50:13 glotze kernel: Stack: c7370e00 c017219d 00000004 c7370e00 00000810 cd2115f4 d05878e7 c7370e00 
> Dec  4 19:50:13 glotze kernel:        d059037e d0590343 d059036f 0000fffe 0000fffe 00000004 00000301 d05969d0 
> Dec  4 19:50:13 glotze kernel:        c7370e00 cd2115c0 00000029 c01727c3 00000400 0804c848 cb9cb740 c7370e20 
> Dec  4 19:50:13 glotze kernel: Call Trace:
> Dec  4 19:50:13 glotze kernel:  [seq_printf+46/82] seq_printf+0x2e/0x52
> Dec  4 19:50:13 glotze kernel:  [pg0+270379239/1069880320] svc_export_show+0x1dd/0x2b1 [nfsd]

That shouldn't happen (of course).

There is a place where a failed kstrdup could lead to this, but that
is rather unlikely and wouldn't be as reproducible as this seems to
be.
If you boot up and then immediately shutdown does this error trigger,
it does it have to be up for a while?

Just before shutting down, can you

   cat /proc/fs/nfsd/exports

and see if that works?  If so, can you show me the contents.
If not, can I see your /etc/exports ??

Thanks,

NeilBrown


This patch fixes a problem that is very unlikely to be yours.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth_unix.c |    4 ++++
 1 file changed, 4 insertions(+)

diff .prev/net/sunrpc/svcauth_unix.c ./net/sunrpc/svcauth_unix.c
--- .prev/net/sunrpc/svcauth_unix.c	2006-12-05 15:20:26.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-12-05 15:20:48.000000000 +1100
@@ -53,6 +53,10 @@ struct auth_domain *unix_domain_find(cha
 			return NULL;
 		kref_init(&new->h.ref);
 		new->h.name = kstrdup(name, GFP_KERNEL);
+		if (new->h.name == NULL) {
+			kree(new);
+			return NULL;
+		}
 		new->h.flavour = &svcauth_unix;
 		new->addr_changes = 0;
 		rv = auth_domain_lookup(name, &new->h);
