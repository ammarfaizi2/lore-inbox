Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWGaUhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWGaUhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWGaUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:37:37 -0400
Received: from pat.uio.no ([129.240.10.4]:40899 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030192AbWGaUhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:37:37 -0400
Subject: Re: [PATCH] sunrpc/auth_gss: NULL pointer deref in
	gss_pipe_release()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alex Polvi <polvi@google.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e561bacc0607310750p2cba1576m6564a356b94dd26c@mail.google.com>
References: <e561bacc0607310750p2cba1576m6564a356b94dd26c@mail.google.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 13:37:22 -0700
Message-Id: <1154378242.13744.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.558, required 12,
	autolearn=disabled, AWL 1.44, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 10:50 -0400, Alex Polvi wrote:
> Proposed (trivial) patch to fix a NULL pointer deref in
> gss_pipe_release(). While this does seem to fix the problem, I'm not
> entirely sure it is the correct place to handle the NULL pointer.
> 
> Included below is the script I used to recreate the problem, the oops,
> and the patch.

Sorry, but that is not the correct fix. The problem here is rather that
something is causing us to call rpc_close_pipes() on the file after the
call to gss_destroy(). That is supposed to be illegal.

Cheers,
  Trond

> polvi@return:~/sysops/experimental/polvi$ cat oopsmynfs.sh
> #!/bin/bash
> 
> cd / # make sure we are not in the dir
> 
> PROG=${0##*/}
> 
> function usage {
>   cat <<EOF
> usage: $PROG /nfs/path/
> 
> will oops sunrpc using the nfs host that serves /nfs/path/
> EOF
>   exit 1
> }
> 
> DIR=$1
> 
> [ -d "$DIR" ] || usage
> 
> sudo umount $DIR 2> /dev/null # just house-keeping...
> 
> sudo mount -o sec=krb5 randomfiler:/vol/to/some/share $DIR # must use krb5
> 
> # with out this ls the cd below will say permission denied and not
> hang after the
> # nfs server has been turned off. It has something to do with stat64
> returning EACCES
> ls $DIR > /dev/null
> 
> echo "Make the nfs server unusable by the client (turn off nfs, iptables, etc)."
> read -p "press enter when ready"
> 
> # if the echo is hit, this script failed to oops sunrpc
> (cd $DIR/. ;  echo "will not cause an oops") & # this should hang
> 
> sudo umount -l $DIR
> 
> echo "Turn the nfs server back on and watch for the oops.  Should not
> take more then 10s"
> 
> 
> [  204.385339] net/sunrpc/rpc_pipe.c: rpc_lookup_parent failed to find
> path /nfs/clnt4/krb5
> [  204.385427] BUG: unable to handle kernel NULL pointer dereference
> at virtual address 0000006c
> [  204.385554]  printing eip:
> [  204.385595] c01d2322
> [  204.385678] *pde = 00000000
> [  204.385719] Oops: 0000 [#1]
> [  204.385781] SMP
> [  204.385875] Modules linked in: des binfmt_misc autofs4 video button
> battery ac nfs lockd af_packet sg sr_mod pcspkr rtc psm
> 
> 
>                                    ouse mousedev ide_disk ide_cd cdrom
> rpcsec_gss_krb5 auth_rpcgss sunrpc ext3 jbd mbcache thermal processor
> fan tg3 sd_mod ide_g
> 
> 
> eneric ata_piix libata scsi_mod generic ide_core unix
> [  204.387417] CPU:    0
> [  204.387418] EIP:    0060:[<c01d2322>]    Not tainted VLI
> [  204.387419] EFLAGS: 00010292   (2.6.18-rc2-git #1)
> [  204.387538] EIP is at _raw_spin_lock+0x12/0x170
> [  204.387578] eax: 00000068   ebx: 00000068   ecx: f7157d3c   edx: f7157d3c
> [  204.387621] esi: 00000068   edi: 00000000   ebp: f7157d00   esp: f7157cdc
> [  204.387664] ds: 007b   es: 007b   ss: 0068
> [  204.387704] Process oopsmynfs.sh (pid: 6114, ti=f7156000
> task=dffb5aa0 task.ti=f7156000)
> [  204.387748] Stack: dffb5aa0 f7157d1c c029ee7d f7157cfc f7156000
> f7156000 f73acd00 00000068
> [  204.388040]        00000000 f7157d0c c029ff7e 00000068 f7157d24
> f88d82cf f73acd00 f73acd00
> [  204.388332]        f73acecc f88e1554 f7157d50 f8cbd6a9 f73acd00
> f7288460 f73acd80 f73acd70
> [  204.388625] Call Trace:
> [  204.388868]  [<c029ff7e>] _spin_lock+0xe/0x10
> [  204.388997]  [<f88d82cf>] gss_pipe_release+0x1f/0x70 [auth_rpcgss]
> [  204.389075]  [<f8cbd6a9>] rpc_close_pipes+0xe9/0x130 [sunrpc]
> [  204.389173]  [<f8cbd91f>] rpc_depopulate+0xff/0x140 [sunrpc]
> [  204.389267]  [<f8cbda8d>] rpc_rmdir+0x6d/0xa0 [sunrpc]
> [  204.389360]  [<f8cac95e>] rpc_destroy_client+0xde/0x110 [sunrpc]
> [  204.389443]  [<f8cac8e1>] rpc_destroy_client+0x61/0x110 [sunrpc]
> [  204.389524]  [<f8cacab7>] rpc_shutdown_client+0xb7/0x120 [sunrpc]
> [  204.389605]  [<f8b2643b>] nfs_kill_super+0x3b/0x90 [nfs]
> [  204.389692]  [<c016e2c1>] deactivate_super+0x81/0xa0
> [  204.389858]  [<c0185522>] mntput_no_expire+0x52/0x90
> [  204.390039]  [<c01770da>] path_release+0x2a/0x30
> [  204.390211]  [<c01715cb>] vfs_stat_fd+0x4b/0x60
> [  204.390378]  [<c0171600>] vfs_stat+0x20/0x30
> [  204.390545]  [<c0171fc9>] sys_stat64+0x19/0x30
> [  204.390712]  [<c0102fb1>] sysenter_past_esp+0x56/0x79
> [  204.390787]  [<b7fff410>] 0xb7fff410
> [  204.390854] Code: 2b c0 89 f8 e8 00 fe ff ff e9 14 ff ff ff 8d 74
> 26 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 24 89 5d f4 8b
> 
> 
>                                      5d 08 89 75 f8 89 7d fc <81> 7b
> 04 ad 4e ad de 75 4c 89 e0 25 00 e0 ff ff 8b 00 39 43 0c
> [  204.392662] EIP: [<c01d2322>] _raw_spin_lock+0x12/0x170 SS:ESP 0068:f7157cdc
> 
> Signed-off-by: Alex Polvi <polvi@google.com>
> ---
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index 4a9aa93..2db3bd1 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -607,6 +607,9 @@ gss_pipe_release(struct inode *inode)
>        struct rpc_auth *auth;
>        struct gss_auth *gss_auth;
> 
> +       if (rpci->ops == NULL)
> +               return;
> +
>        clnt = rpci->private;
>        auth = clnt->cl_auth;
>        gss_auth = container_of(auth, struct gss_auth, rpc_auth);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

