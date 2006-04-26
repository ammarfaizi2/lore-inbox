Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWDZPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWDZPsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWDZPsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:48:04 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:46734 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964825AbWDZPsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:48:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cnx78CD0opuPV+FGwpA5EqczphDT3FpzPrHFTQRqrBKW0TfLvQKkyqMWDZ6YZOuIiUEshsGP8hpDGgTk82VQjkyeeYmGzpjxHPoZc7taAEaC5exfvCVQPk+hKUjk9sTuNZj+/4mzEUF9AlPr1yLrYiEDFElwjPuZDZmhU3+PzFA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Date: Wed, 26 Apr 2006 17:47:54 +0200
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604212034.53486.blaisorblade@yahoo.it> <20060425162941.GB22807@ccure.user-mode-linux.org>
In-Reply-To: <20060425162941.GB22807@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261747.54660.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 18:29, Jeff Dike wrote:
> On Fri, Apr 21, 2006 at 08:34:52PM +0200, Blaisorblade wrote:
> > >  #define PTRACE_GET_THREAD_AREA    25
> > >  #define PTRACE_SET_THREAD_AREA    26
> > > +#define PTRACE_SYSCALL_MASK	  27
> >
> > I think there could be a reason we skipped that for SYSEMU - that's to
> > see. Also, if this capability will be implemented in other archs, we
> > should use the 0x4200-0x4300 range for it.
>
> Yeah, we need to decide somewhat carefully which number to use.
>
> > > +		for(i = NR_syscalls; i < len * 8; i++){
> > > +			get_user(c, &mask[i / 8]);
> >
> > This get_user() inside a loop is poor, it could slow down a valid call.
> > It'd be simpler to copy the mask from userspace in a local variable (with
> > 400 syscalls that's 50 bytes, i.e. fully ok), and then perform the
> > checks, if wanted (I disagree with Heiko's message, this check is needed
> > sometimes - see  my response to that).
>
> Agree, except that we need to be careful about when userspace knows
> about more system calls than the kernel.  We should copy-user as many
> bits as the kernel knows about (or the process passes in, which ever
> is less) and if the process knows about more system calls than the
> kernel, the extra bits should be checked (maybe in a get_user(c, ...)
> loop) to make sure that special treatment isn't being requested for
> unknown syscalls.

Yes, that's exactly what I thought. The get_user() loop isn't that nice but 
that's possibly a minor point.

> > And only after that set all at once child->syscall_mask. You copy twice
> > that little quantity of data but that's not at all time-critical, and
> > you're forced to do that to avoid partial updates; btw you've saved
> > getting twice the content from userspace (slow when address spaces are
> > distinct, like for 4G/4G or SKAS implementation of copy_from_user).

> Yup.

> > Actually we would copy the whole struct in my API proposal (as I've
> > described in the other message, we need to pass another param IMHO,
> > so we'd pack them in a struct and pass its address).

> You mean adding a fifth argument to ptrace?  I don't really like that
> idea.  We could either make two new PTRACE_* operations (I don't like
> the MASK_STRICT_VERIFY option since that seems unnecessary and
> fragile) or make the data argument something like this

> Except that passing pointers to pointers into system calls seems like
> a bad idea - it makes ptrace look (more) like ioctl.  So, you'd want
> something like
> 	struct {
> 		int flag;
> 		char mask[(NR_syscalls + 7)/8];
> 	}
>
> then you'd want the length back in data so you know how much data the
> process is giving you.

Yes, this is what I mean.

> But then, you'll read the smaller of the 
> kernel's and process's version of the structure, and if the process
> one is bigger, you need to read the extra bits to sanity-check them.
> Given that you'll need this extra treatment,

You need this treatment anyway - above we're passing a pointer to a bitstring, 
here we're passing a pointer to a struct containing a bitstring, in both 
cases we must copy in the right amount of bytes.

> I think it's simpler to 
> just leave the addr argument as a pointer to the bits and add an extra
> ptrace op.

If we can do without MASK_STRICT_VERIFY, that works fully, and anyway it's 
simpler - however, say, when running strace -e read,tee (sys_tee will soon be 
added, it seems) this call would fail, while it would be desirable to have it 
work as strace -e read.

MASK_STRICT_VERIFY isn't necessarily the best solution, but if userspace must 
search the maximum allowed syscall by multiple attempts, we've still a bad 
API.

Probably, a better option (_instead_ of MASK_STRICT_VERIFY) would be to return 
somewhere an "extended error code" saying which is the last allowed syscall 
or (better) which is the first syscall which failed. I.e. if there is strace 
-e read,splice,tee and nor splice nor tee are supported, then this value 
would be __NR_splice and strace (or any app) could then decide what to do.

To do that we need again a structure with a field where to store the code 
(which _must_ be at the beginning).

But this is cleaner than saying to the kernel "interpret what I say if I'm 
wrong", and I said above the complexity is the same when copying the 
structure.

And I'd use this together with the "two ptrace codes" idea.
Let's say we'll use PTRACE_TRACE_ONLY or PTRACE_TRACE_EXCEPT.

Another possibility (which however implies implementation for all 
architectures) is to put these two requests between ptrace options (i.e. 
PTRACE_SETOPTIONS), where it logically belongs (and this is the only point 
reason to do it this way); however we have then only one parameter, which 
would become then a pointer to such a structure:

struct {
	int ret_code;
	int mask_len;
	char mask[];
};
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
