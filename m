Return-Path: <linux-kernel-owner+w=401wt.eu-S1030196AbXAKOxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbXAKOxm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXAKOxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:53:42 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:44731 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1030196AbXAKOxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:53:41 -0500
Message-ID: <368527150.02925@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 11 Jan 2007 22:53:10 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070111145309.GA6226@mail.ustc.edu.cn>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <367964923.02447@ustc.edu.cn> <20070105024226.GA6076@mail.ustc.edu.cn> <17828.33075.145986.404400@notabene.brown> <368438638.13038@ustc.edu.cn> <20070110141756.GA5572@mail.ustc.edu.cn> <17829.46603.14554.981639@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17829.46603.14554.981639@notabene.brown>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

On Thu, Jan 11, 2007 at 02:59:07PM +1100, Neil Brown wrote:
> On Wednesday January 10, fengguang.wu@gmail.com wrote:
> > 
> > root ~# mount localhost:/suse /mnt
> > [  132.678204] svc: unknown version (3 for prog 100227, nfsd)
> > 
> > I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
> > have this warning, while 2.6.17-2-amd64 is good.
> 
> Thanks.  That helps a lot.
> 
> This patch should help too.  Please let me know.

# mount localhost:/suse /mnt
[ 2058.438236] svc: unknown version (3 for prog 100227, nfsd)

# pss nfs
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      5488  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5489  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5490  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5491  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5492  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5493  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5494  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
root      5495  0.0  0.0      0     0 ?        S    22:16   0:00 [nfsd]
# pss rpc
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      5486  0.0  0.0      0     0 ?        S<   22:16   0:00 [rpciod/0]
root      5487  0.0  0.0      0     0 ?        S<   22:16   0:00 [rpciod/1]
root      5499  0.0  0.0   7944   668 ?        Ss   22:16   0:00 /usr/sbin/rpc.mountd
statd     5567  0.0  0.0   7892  1084 ?        Ss   22:16   0:00 /sbin/rpc.statd
root      5578  0.0  0.0  23180   652 ?        Ss   22:16   0:00 /usr/sbin/rpc.idmapd

Thanks,
Wu

> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/nfsd/nfssvc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
> --- .prev/fs/nfsd/nfssvc.c	2007-01-11 14:55:38.000000000 +1100
> +++ ./fs/nfsd/nfssvc.c	2007-01-11 14:57:03.000000000 +1100
> @@ -72,7 +72,7 @@ static struct svc_program	nfsd_acl_progr
>  	.pg_prog		= NFS_ACL_PROGRAM,
>  	.pg_nvers		= NFSD_ACL_NRVERS,
>  	.pg_vers		= nfsd_acl_versions,
> -	.pg_name		= "nfsd",
> +	.pg_name		= "nfsacl",
>  	.pg_class		= "nfsd",
>  	.pg_stats		= &nfsd_acl_svcstats,
>  	.pg_authenticate	= &svc_set_client,
> @@ -121,13 +121,13 @@ int nfsd_vers(int vers, enum vers_op cha
>  		break;
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  		if (vers < NFSD_ACL_NRVERS)
> -			nfsd_acl_version[vers] = nfsd_acl_version[vers];
> +			nfsd_acl_versions[vers] = nfsd_acl_version[vers];
>  #endif
>  	case NFSD_CLEAR:
>  		nfsd_versions[vers] = NULL;
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  		if (vers < NFSD_ACL_NRVERS)
> -			nfsd_acl_version[vers] = NULL;
> +			nfsd_acl_versions[vers] = NULL;
>  #endif
>  		break;
>  	case NFSD_TEST:
