Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRCBScB>; Fri, 2 Mar 2001 13:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCBSbu>; Fri, 2 Mar 2001 13:31:50 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:61198 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129324AbRCBSbj>; Fri, 2 Mar 2001 13:31:39 -0500
Message-ID: <3A9FE589.610D5220@mvista.com>
Date: Fri, 02 Mar 2001 10:25:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Christopher Friesen <cfriesen@nortelnetworks.com>,
        John Being <olonho@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen 
 similar          problem on PPC
In-Reply-To: <Pine.LNX.3.95.1010302103506.1920A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 2 Mar 2001, Christopher Friesen wrote:
> 
> > John Being wrote:
> >
> > > gives following result on box in question
> > > root@******:# ./clo
> > > Leap found: -1687 msec
> > > and prints nothing on all other  my boxes.
> > > This gives me bunch of troubles with occasional hang ups and I found nothing
> > > in kernel archives at
> > > http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
> > > just some notes about smth like this for SMP boxes with ntp. Is this issue
> > > known, and how can I fix it?
> >
> > I've run into non-monotonic gettimeofday() on a PPC system with 2.2.17, but it
> > always seemed to be almost exactly a jiffy out, as though it was getting
> > hundredths of a second from the old tick, and microseconds from the new tick.
> > Your leap seems to be more unusual, and the first one I've seen on an x86 box.
> >
> > Have you considered storing the results to see what happens on the next call?
> > Does it make up the difference, or do you just lose that time?
> >
> > Chris
> 
> I think it's a math problem in the test code. Try this:
> 
> #include <stdio.h>
> #include <sys/time.h>
> 
> #define DEB(f)
> 
> int main()
> {
>     struct timeval t;
>     double start_us;
>     double stop_us;
>     for(;;)
>     {
>         gettimeofday(&t, NULL);
>         start_us  = (double) t.tv_sec * 1e6;
>         start_us += (double) t.tv_usec;
>         gettimeofday(&t, NULL);
>         stop_us  = (double) t.tv_sec * 1e6;
>         stop_us += (double) t.tv_usec;
>         if(stop_us <= start_us)
>             break;
>         DEB(fprintf(stdout, "Start = %f, Stop = %f\n", start_us, stop_us));
>     }
>     fprintf(stderr, "Start = %f, Stop = %f\n", start_us, stop_us);
>     return 0;
> }
> 
> Note that two subsequent calls to gettimeofday() must not return the
> same time even if your CPU runs infinitely fast. I haven't seen any
> kernel in the past few years that fails this test.

Oh!  With only micro second resolution how is this avoided?  The only
"legal" thing to do to avoid this is for the fast boxes to loop until
the requirement is satisfied.  Is this really done?

George
