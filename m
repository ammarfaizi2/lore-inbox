Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130199AbQJWSx3>; Mon, 23 Oct 2000 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129896AbQJWSxT>; Mon, 23 Oct 2000 14:53:19 -0400
Received: from f90.law4.hotmail.com ([216.33.149.90]:56839 "EHLO hotmail.com") by vger.kernel.org with ESMTP id <S129600AbQJWSxJ>; Mon, 23 Oct 2000 14:53:09 -0400
X-Originating-IP: [143.183.152.17]
From: "Lyle Coder" <x_coder@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: dank@alumni.caltech.edu
Date: Mon, 23 Oct 2000 18:37:14 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F9029R5JuhXtwJffTW200002b3a@hotmail.com>
X-OriginalArrivalTime: 23 Oct 2000 18:37:14.0545 (UTC) FILETIME=[43671210:01C03D20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
If you have a similar machine (in terms machine configuration) for both your 
solaris and linux machines... could you tell us what the difference in total 
time for 100 and 10000 was?  i.e... dont compare solaris with 100 
descripters vs solaris with 10000 descriptors, but rather
Linux 100 descripters Vs. Solaris 100 descriptors  AND
Linux 10000 descriptors Vs. Solaris 10000 descriptors.

That would be useful informatio... I think.

Thanks
Lyle

Re: Linux's implementation of poll() not scalable?

[ Small treatize on "scalability" included. People obviously do not
  understand what "scalability" really means. ]

In article <39F28A86.1D07DBFF@alumni.caltech.edu>,
Dan Kegel  <dank@alumni.caltech.edu> wrote:
>I ran a benchmark to see how long a call to poll() takes
>as you increase the number of idle fd's it has to wade through.
>I used socketpair() to generate the fd's.
>
>Under Solaris 7, when the number of idle sockets was increased from 100 to 
>10000, the time to check for active sockets with poll() increased by a 
>factor of only 6.5.  That's a sublinear increase in time, pretty spiffy.

Yeah. It's pretty spiffy.

Basically, poll() is _fundamentally_ a O(n) interface. There is no way
to avoid it - you have an array, and there simply is _no_ known
algorithm to scan an array in faster than O(n) time. Sorry.

(Yeah, you could parallellize it.  I know, I know.  Put one CPU on each
entry, and you can get it down to O(1).  Somehow I doubt Solaris does
that.  In fact, I'll bet you a dollar that it doesn't).

So what does this mean?

Either

(a) Solaris has solved the faster-than-light problem, and Sun engineers
     should get a Nobel price in physics or something.

(b) Solaris "scales" by being optimized for 10000 entries, and not
     speeding up sufficiently for a small number of entries.

You make the call.

Basically, for poll(), perfect scalability is that poll() scales by a
factor of 100 when you go from 100 to 10000 entries. Anybody who does
NOT scale by a factor of 100 is not scaling right - and claiming that
6.5 is a "good" scale factor only shows that you've bought into
marketing hype.

In short, a 6.5 scale factor STINKS. The only thing it means is that
Solaris is slow as hell on the 100 descriptor case.

>Under Linux 2.2.14 [or 2.4.0-test1-pre4], when the number of idle sockets 
>was increased from  100 to 10000, the time to check for active sockets with 
>poll() increased by a factor of 493 [or 300, respectively].

So, what you're showing is that Linux actually is _closer_ to the
perfect scaling (Linux is off by a factor of 5, while Solaris is off by
a factor of 15 from the perfect scaling line, and scales down really
badly).

Now, that factor of 5 (or 3, for 2.4.0) is still bad.  I'd love to see
Linux scale perfectly (which in this case means that 10000 fd's should
take exactly 100 times as long to poll() as 100 entries take).  But I
suspect that there are a few things going on, one of the main ones
probably being that the kernel data working set for 100 entries fits in
the cache or something like that.

>Please, somebody point out my mistake.  Linux can't be this bad!

I suspect we could improve Linux in this area, but I hope that I pointed
out the most fundamental mistake you did, which was thinking that
"scalability" equals "speed".  It doesn't.

Scalability really means that the effort to handle a problem grows
reasonably with the hardness of the problem. And _deviations_ from that
are indications of something being wrong.

Some people think that super-linear improvements in scalability are
signs of "goodness".  They aren't.  For example, the classical reason
for super-linear SMP improvement (with number of CPU's) that people get
so excited about really means that something is wrong on the low end.
Often the "wrongness" is lack of cache - some problems will scale better
than perfectly simply because with multiple CPU's you have more cache.

The "wrongess" is often also selecting the wrong algorithm: something
that "scales well" by just being horribly slow for the small case, and
being "less bad" for the big cases.

In the end, the notion of "scalability" is meaningless. The only
meaningful thing is how quickly something happens for the load you have.
That's something called "performance", and unlike "scalability", it
actually has real-life meaning.

Under Linux, I'm personally more worried about the performance of X etc,
and small poll()'s are actually common. So I would argue that the
Solaris scalability is going the wrong way. But as performance really
depends on the load, and maybe that 10000 entry load is what you
consider "real life", you are of course free to disagree (and you'd be
equally right ;)

Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

Share information about yourself, create your own public profile at 
http://profiles.msn.com.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
