Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJaOoN>; Thu, 31 Oct 2002 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJaOoN>; Thu, 31 Oct 2002 09:44:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56996 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262446AbSJaOoL>;
	Thu, 31 Oct 2002 09:44:11 -0500
Date: Thu, 31 Oct 2002 20:22:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net
Subject: Re: What's left over 
Message-ID: <20021031202237.A3679@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20021031020836.E576E2C09F@lists.samba.org> <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 31, 2002 at 02:39:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:39:23AM +0000, Linus Torvalds wrote:
> 
> On Thu, 31 Oct 2002, Rusty Russell wrote:
> > 
> > 	Here is the list of features which have are being actively
> > pushed, not NAK'ed, and are not in 2.5.45.  There are 13 of them, as
> > appropriate for Halloween.
> 
> I'm unlikely to be able to merge everything by tomorrow, so I will 
> consider tomorrow a submission deadline to me, rather than a merge 
> deadline. That said, I merged everything I'm sure I want to merge today, 
> and the rest I simply haven't had time to look at very much.
> 
> 
> > Crash Dumping (LKCD)
> 
> This is definitely a vendor-driven thing. I don't believe it has any 
> relevance unless vendors actively support it.
> 

Linus,

I wish you could have made it to the OLS RAS BOF and seen this for
yourself - the vendor support, the need and the drive towards a 
unified and flexible dumping framework. 

The problem with dump has not been lack of vendor interest. There
wouldn't have been multiple dump type implementations floating around 
if there wasn't a need  --  LKCD, Mission Critical dump, Ingo's
network dump, kmsgdump, Rusty's oops dumper to cite some. The difficulty
has been technical and hence the diversity of approaches that different
projects came up with to tackle the problem (arising from slightly
different priorities and environments in each case). The second has
been related to preferences in the kind of user level analysis tools.

And the LKCD project has been evolving to address these very 
problems to bring the best of these worlds together and also allow
flexibility on the choice of analysis tools !

Mission critical Linux project code base for example is now being 
maintained as part of the LKCD project. Either lcrash or mission 
critical linux crash can be used for analysing LKCD dumps. 

And on the kernel side of things:

(a) The dump driver interface in LKCD has been specifically 
    designed to enable different kinds of dumping mechanisms and 
    targets to be supported -- generic block, network dump , 
    polled-IDE (Rusty style) etc, even alternate dump targets failover 
    and multiple dump devices in the future if required. We are also 
    experimenting with a memory dump driver to save dump to memory 
    and dump after a memory preserving soft-boot, reusing the mission 
    critical mcore technique.
(b) Selective dumping, for different levels of dump data - one
    option that was added recently would dump all kernel pages
    and is likely to be commonly used (gzip compressed dump). Its
    pretty easy to extend to more selectivity or different levels
    and the dump also occurs in passes from more critical data to 
    less critical.
    (The page in use flag was added to help with this)
(c) The core pieces which touch the kernel as such just add basic 
    infrastructure that is needed in the kernel for any dumping 
    facility. Includes:
	- Enabling IPI to collect CPU state on all processors in the
	  system right when dump is triggered (may not be a normal
	  situation, so NMIs where supported are the best option)
	- Ability to quiesce (silence) the system before dumping 
	  (and if in non-disruptive mode, then restore it back)
	- Calls into dump from kernel paths (panic, oops, sysrq
	  etc). 
	- Exports of symbols to help with physical memory 
	  traversal and verification

As Matt has said there is an active development community behind 
LKCD and lot of the drive for that has come from companies who use it 
and are really hoping hard that it becomes part of the mainline.

BTW, the code has also been scrutinised and reviewed over
lkml as well and undergone iterations of releases following 
that. Anything else there that you think needs to be fixed please
do let us know.

Regards
Suparna

