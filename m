Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131513AbRCXJc7>; Sat, 24 Mar 2001 04:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRCXJcj>; Sat, 24 Mar 2001 04:32:39 -0500
Received: from unthought.net ([212.97.129.24]:35459 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131513AbRCXJch>;
	Sat, 24 Mar 2001 04:32:37 -0500
Date: Sat, 24 Mar 2001 10:31:55 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010324103155.A9686@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net> <vbawv9hyuj0.fsf@mozart.stat.wisc.edu> <99h9p6$2j9$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <99h9p6$2j9$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 23, 2001 at 09:02:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 09:02:30PM -0800, Linus Torvalds wrote:
> In article <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>,
> Kevin Buhr <buhr@stat.wisc.edu> wrote:
> >
> >The results speak for themselves:
> >
> >    CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:
> >                      
> >    real    16m8.423s     real    8m2.417s     real    12m24.939s
> >    user    15m23.710s    user    7m22.200s    user    10m14.420s
> >    sys     0m48.730s     sys     0m41.040s    sys     2m13.910s 
> >maps:    <250 lines           <250 lines          >3000 lines
> >
> >Obviously, the *real* problem is RedHat GCC 2.96.  If Linus bothers to
> >write this patch (he probably already has),
> 
> Check out 2.4.3-pre7, I'd be interested to hear what the system time is
> for that one.

I was unable to compile gcc-3.0 from CVS this morning - so no tests there
for now...

First the "small" test case:
-----------------------------
2.4.2:
  gcc-2.96:  -O6 -felide-constructors -fPIC
  real    7m31.748s
  user    3m52.340s
  sys     3m38.180s
  Memory consumption:  ~200MB

2.4.3-pre7:
  gcc-2.96:  -O6 -felide-constructors -fPIC
  real    3m52.347s
  user    3m46.120s
  sys     0m3.370s

That's pretty darn impressive Linus !  3m38 -> 3sec !  Now if the GCC people
could only repeat that trick   ;)


Then the bigger one:
-----------------------------
2.4.2:
  gcc-2.96:  -O6 -felide-constructors -fPIC
  Fails compilation with "Virtual memory exhausted!" after
  real    37m28.305s
  user    23m39.930s
  sys     13m44.900s
  Memory consumption:  ~300MB before failure

Note - there are no ulimits set, and the machine has more than enough memory

2.4.3-pre7:
  gcc-2.96:  -O6 -felide-constructors -fPIC
  real    31m48.898s
  user    31m21.460s
  sys     0m26.980s
  Memory consumption:  ~400MB - successful completion

Cool !  I can work again   ;)
 
> 
> It does seem like gcc-2.96 is kind of special, but considering how easy
> it is to merge anonymous memory (most of the changes were cosmetic ones
> to get nice ordering to make the merge trivial without having to
> allocate a vma that never gets used etc), it's certainly worth doing.

Beautiful !

Also, the speedup gained here is ~70 times, which may be more than the changed
allocation in gcc-3 will buy us (was that 32 times?).  And,  after all,  there
_has_ to be some other case out there which is not as easily fixed as the GCC
one.

> 		Linus

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
