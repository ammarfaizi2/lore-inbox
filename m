Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSAITfd>; Wed, 9 Jan 2002 14:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAITfY>; Wed, 9 Jan 2002 14:35:24 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:1431
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288971AbSAITfP>; Wed, 9 Jan 2002 14:35:15 -0500
Message-Id: <200201091919.g09JJtA26375@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: can we make anonymous memory non-EXECUTABLE?
Date: Wed, 9 Jan 2002 06:32:39 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201090049390.2985-100000@imladris.surriel.com> <3C3BB05D.1040501@zytor.com>
In-Reply-To: <3C3BB05D.1040501@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2002 09:52 pm, H. Peter Anvin wrote:
> Rik van Riel wrote:
> > On 8 Jan 2002, H. Peter Anvin wrote:
> >>One way to do this would be to create a newbrk() syscall which takes a
> >>permission argument (for new pages.)
> >
> > ITYM mmap(2)
>
> That's an idea, too.  WTF do we actually need brk() for?  If it's only
> there to be annoying, let's get rid of it completely and let the C
> library implement it -- stating its assumptions explicitly.
>
> 	-hpa

There was a fun little panel a few months back at Atlanta Linux Showcase 
(which was inexplicably held in california this year, but I'm told they're 
patching that in the next release... :)

Apparently, for mallocs below a certain size, glibc uses brk, and above a 
certain size, it uses mmap.  And the mmap variant is something like 10 times 
slower than the brk variant, because of all the soft page faults, fiddling 
with page tables, associated cache trashing, etc.  (The guy found it trying 
to figure out why his app was SLOWER on Linux than on Irix, and eventually 
found a glibc variable that could make linux faster: raising glibc's 
threshold where it does brk for malloc to infinity.)

Glibc does mmap instead of brk because theoretically brk can leave wasted 
memory between fragments, although apparently nobody's ever seen more than 
10% waste in a live program, and the speed penality of taking a soft page 
fault at access time to muck about with the page tables is a LOT bigger than 
10%...

Rob
