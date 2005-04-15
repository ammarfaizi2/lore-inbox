Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVDONVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVDONVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 09:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVDONVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 09:21:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25810 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261736AbVDONVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 09:21:46 -0400
Date: Fri, 15 Apr 2005 14:21:45 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christoph Hellwig <hch@infradead.org>, matthew@wil.cx, juhl-lkml@dif.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Message-ID: <20050415132145.GA8669@parcelfarce.linux.theplanet.co.uk>
References: <20050415113218.GA22528@infradead.org> <E1DMPXN-0004sh-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DMPXN-0004sh-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 10:03:05PM +1000, Herbert Xu wrote:
> I suppose it could be smart and stay quiet about
> 
> val < 0 || val > BOUND
> 
> However, gcc is slow enough as it is without adding unnecessary
> smarts like this.

It only warns with -W on, not with -Wall, so I see no compelling
reason to fix this.  I think the real problem here is that 'arg'
is declared 2 pages earlier in the function prototype (aka the
function-growth-hormone-imbalance syndrome).

There's two good ways of fixing this, adding a f_setsig() function:

static inline int f_setsig(struct file *filp, unsigned long arg)
{
	if (arg > _NSIG)
		return -EINVAL;

	filp->f_owner.signum = arg;
	return 0;
}
...
	case F_SETSIG:
		err = f_setsig(filp, arg);
		break;

or add a function that checks a variable to see if it's a valid signal number:

#define valid_signal(arg)	((unsigned long)arg <= _NSIG)
...
	case F_SETSIG:
		if (!valid_signal(arg))
			break;
		err = 0;
		filp->f_owner.signum = arg;
		break;

Looks like futex.c, ptrace.c, signal.c, sys.c and almost every
architecture's ptrace code could easily make use of the latter, but not
the former.  It also looks like we have a few off-by-one errors.  For
example, in h8300's ptrace code:

                case PTRACE_SYSCALL:
                case PTRACE_CONT: {
                        ret = -EIO;
                        if ((unsigned long) data >= _NSIG)
                                break ;

but

                case PTRACE_SINGLESTEP: {
                        ret = -EIO;
                        if ((unsigned long) data > _NSIG)
                                break;

so I'd recommend the second solution.  But be careful not to "fix up"
cases like:

./kernel/exit.c:        if (sig < 1 || sig > _NSIG)

where we really don't want to allow zero.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
