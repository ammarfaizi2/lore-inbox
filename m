Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSEVUoK>; Wed, 22 May 2002 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEVUoJ>; Wed, 22 May 2002 16:44:09 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:5841 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S313628AbSEVUoI>; Wed, 22 May 2002 16:44:08 -0400
Message-Id: <200205222043.g4MKhsw06808@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Pavel Machek <pavel@suse.cz>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Wed, 22 May 2002 13:43:31 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com> <20020522141747.G37@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 May 2002 10:17 am, Pavel Machek wrote:
> Hi
>
> > Nice. This also closes another issue pointed out: freezing
> > a process while it is holding the mmap_sem, which may be needed later
> > while collecting thread registers on IA64.
> >
> > Now that Linus has accepted Pavel's swsusp, do you have any thoughts
> > on using Pavel's scheme to freeze processes?
>
> I attempt half of signal delivery to the threads, but that should not be
> a problem. Currently freezing stuff is there only for CONFIG_SWSUSP case,
> but it is probably small enough to be there unconditionaly.
> 								Pavel

I think that although my tcore_suspend_threads and Pavel's freeze_processes 
have similar results, I don't think using Pavel's approach for the core dump 
is a good idea.

1) SMP is a stability problem.  I want TCore to work for 2.4x kernels  
soon. 
2) To avoid the issues with I/O bound threads waking up, Pavel's design waits 
for the signal to get them running and then drops them in the "refrigerator". 
 
My design is explicitly going for the most accurate core dump it can.  
If I need to wait for processes to wake up and get frozen on a large SMB box 
then we can loose a lot of accuracy.

I do however; think Pavels work could benefit from using some of my approach. 
 It might simplify all those places where his patch tests p->state | 
PK_FREEZE and then calls  refrigerator.   It perhaps make it work better for 
SMP if software suspend is considered a usefull feature on a SMP systems.

It would still need to wait for all the I/O bound processes to finish their 
pending I/O but, I think it could be made to work.

--mgross

