Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289568AbSAPWUJ>; Wed, 16 Jan 2002 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289600AbSAPWT7>; Wed, 16 Jan 2002 17:19:59 -0500
Received: from unthought.net ([212.97.129.24]:55434 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S289568AbSAPWTs>;
	Wed, 16 Jan 2002 17:19:48 -0500
Date: Wed, 16 Jan 2002 22:47:19 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: mcuss@cdlsystems.com, linux-kernel@vger.kernel.org
Subject: Re: Measuring execution time
Message-ID: <20020116224719.M2830@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Chris Friesen <cfriesen@nortelnetworks.com>, mcuss@cdlsystems.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201151409270.1744-100000@barbarella.hawaga.org.uk> <042f01c19e13$6da6f4f0$160e10ac@hades> <3C45B715.926A0BA0@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C45B715.926A0BA0@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Wed, Jan 16, 2002 at 12:23:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:23:33PM -0500, Chris Friesen wrote:
> Mark Cuss wrote:
> 
> > I am working on optimizing some software and would like to be able to
> > measure how long an instruction takes (down to the clock cycle of the CPU).
> > I recall reading somewhere about a kernel time measurement called a "Jiffy"
> > and figured that it would probably apply to this.
> > 
> > If anyone has any tips on how to figure out how to do this I'd really
> > appreciate it.
> 
> Jiffies are quite coarse-grained.  On x86 you want the rdtsc instruction, while
> on ppc you want mfrtcu/mfrtcl or mftbu/mftb depending on the version of the
> chip.  These are used as inline assembly, and if you do a google search you
> should be able to find code snippets.

However,  rdtsc will completely change how your decoders fill, how busy your
execution units are, it will interfere with every singe stage in the CPU
from the fetch logic to the retirement and write buffer.

Your cycle will not behave "as usual" if you put rdtscs around it.

I usually put an rdtsc in the very beginning of a routine, and an rdtsc
at the end.  Then I have the assembly following the last rdtsc increment
a counter in an array (after a bounds check).  The index in the array
is the number of clock cycles I spent.

After running the function some thousands of times, you will have a nice
histogram in your array, usually with some skewed bell-like curve (you can
see many interesting kinds of double/triple bells etc. all depending on
your code).

Changing just one or two instructions in the function, then re-running the
code and re-plotting the histogram, will displace the peak of the bell curve
in some direction.  This will tell you how your change affected the code
in "typical number of clock cycles".

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
