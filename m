Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270261AbRHWUL2>; Thu, 23 Aug 2001 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270258AbRHWULS>; Thu, 23 Aug 2001 16:11:18 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:51890 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S270195AbRHWULI>; Thu, 23 Aug 2001 16:11:08 -0400
Date: Thu, 23 Aug 2001 21:11:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010823211121.H24974@flint.arm.linux.org.uk>
In-Reply-To: <20010817125727.A16475@hq2> <3B7D76EF.DA34EB23@mvista.com> <20010822194035.K18391@flint.arm.linux.org.uk> <3B8561B9.AC440835@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8561B9.AC440835@mvista.com>; from george@mvista.com on Thu, Aug 23, 2001 at 01:04:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 01:04:09PM -0700, george anzinger wrote:
> Sorry, but none of those system calls requires the registers which is
> where the problem is.

/* Fork a new task - this creates a new program thread.
 * This is called indirectly via a small wrapper
 */
asmlinkage int sys_fork(struct pt_regs *regs)
                        ^^^^^^^^^^^^^^^^^^^^
{
        return do_fork(SIGCHLD, regs->ARM_sp, regs, 0);
}

/* sys_execve() executes a new program.
 * This is called indirectly via a small wrapper
 */
asmlinkage int
sys_execve(char *filenamei, char **argv, char **envp, struct pt_regs *regs)
                                                     ^^^^^^^^^^^^^^^^^^^^^
{
        int error;
        char * filename;

        filename = getname(filenamei);
        error = PTR_ERR(filename);
        if (IS_ERR(filename))
                goto out;
        error = do_execve(filename, argv, envp, regs);
        putname(filename);
out:
        return error;
}

Certainly looks to me like they do.  See the highlighted arguments.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

