Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVBOSph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVBOSph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBOSoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:44:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10432 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261820AbVBOSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:43:13 -0500
Date: Tue, 15 Feb 2005 18:43:07 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:01:49PM +1100, Stephen Rothwell wrote:
> Parisc seemed to assume th existance of compat_sys_waitid.

PA-RISC already has a compat_sys_waitid ;-P

The reason it isn't in Linus' tree yet is that it depends on the
is_compat_task() predicate which Andi vetoed out of Andrew's tree.
As a result, I haven't been able to merge any of the compat stuff
sitting in the PA tree.  A few more voices in favour of reintroducing
is_compat_task() would help.

> @@ -413,6 +414,36 @@ compat_sys_wait4(compat_pid_t pid, compa
>  	}
>  }
>  
> +asmlinkage long compat_sys_waitid(u32 which, u32 pid,
> +		struct compat_siginfo __user *uinfo, u32 options,
> +		struct compat_rusage __user *uru)

Some subtle differences which I feel incompetent to diagnose ... ours
looks like:

asmlinkage int compat_sys_waitid(int which, pid_t pid,
                                 compat_siginfo_t __user *infop, int options,
                                 struct compat_rusage __user *ru)


> +	BUG_ON(info.si_code & __SI_MASK);
> +	info.si_code |= __SI_CHLD;
> +	return copy_siginfo_to_user32(uinfo, &info);
> +}

Other than variable names, we're identical to this point:

        /* Tell copy_siginfo_to_user that it was __SI_CHLD */
        ksiginfo.si_code |= __SI_CHLD;
        
        if (compat_copy_siginfo_to_user(infop, &ksiginfo) != 0)
                return -EFAULT;

        return 0;
}

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
