Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVDPQtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVDPQtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVDPQtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:49:52 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:42973 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262700AbVDPQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:49:46 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6 upgrade overall failure report
Date: Sat, 16 Apr 2005 16:20:16 GMT
Message-ID: <055FPDS12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started to move production servers to kernel 2.6 a year ago, but the
strange situation is that one year later, most of them are back to 2.4
This did not append with 2.0 -> 2.2 or 2.2 -> 2.4 upgrade.

Here are the factual technical reasons:

Right from the beginning, the core 2.6 kernel was rock solid for me, so I had
no crash to complain, but ...

. I reported a year ago that SCSI fusion was unable to properly recover from
  tiny errors under 2.6 as opposed to 2.4 ... and got hit by the same problem
  6 monthes later

. There is still a memory leak trouble (probably in tigon3 driver since others
  reported so on kernel mailing list, and tigon3 is not a geek hardware since
  most nowdays lowend servers use either tigon3 or pro1000)

. There have been USB storage issues, also they are now solved

. Since 2.6.10, the TCP task does not work anymore with OSX (2 Mbps instead
  of 60 Mbps on a 100 Mbps wire)

Each time I get a problem with a kind of hardware, I move to what I find the
most stable for it, until I'm sure the problem has been solved with up to date
kernel, and the current result is that I have more and more servers back to
2.4


So, I could conclude with many others that the 2.6 development model is
worse than the old one, but I don't think so. I think the problem to solve
is handling the complexity, and it's a new issue, and neither the old
development model nor the new one are suited at the moment because the
change is more fondamental: you now have to deal with complexity versus
stability.

In real world, there are very fiew situations where top performances on
the kernel side will change the situation. Most real life tasks are either
easily handled by modern hardware, so even a naive 2.0 kernel would be fine,
or too complex for the hardware, so the kernel cannot fill the gap; only new
harware will do.
On the other hand, selling people are very much interested in new features
or better benchmarks because it's what will make their job easier.
So, as a result of it's success, Linux kernel is focusing probably a bit
more than necessary on high performances. This is even more true since most
high profile developpers are now beeing given high end machines (Linus a
PowerPC, kernel.org a quad opteron, etc).

Now, what's wrong with that ?
Well, the fact is that new hardware is only supported by latest kernel,
so at the end, you have to upgrade, and so you get more and more complexity
whether you like it or not.
As an example, for servers, 2.4 is still fine, but laptops already require 2.6
As a result, the complexity versus stability compromise is less and less
suited for most real life uses.

Now the problem with the kernel complexity is:
. ultimate implementation requires much more testing than simple good one (TCP
  sample)
. it makes life harder for device drivers writers (tigon3 or fusion sample)

So, back to Linux kernel development model, what is now flowed is to assume
that the last development kernel will be the good candidate for the next
stable one. It was true as long as the overall complexity was low;
it's not any more.

The second bad attitude is to not require a new device drivers to be included
in the sable kernel (I'm assuming current stable is 2.4) before entering the
development kernel because it will make upgrade mandatory sooner.

So, basically, we need two trees, one conservative focusing on clean simple
implementation (single kernel lock such as in 2.0, good basic algorithms,
no more), and one focusing on top performances,
with each driver beeing written first for the simple tree, then ported to the
advanced one.

Now, we can't say, ok there are Linux alternatives that are more conservative,
so would fit my conservative kernel definition, because we also need concerted
design between the two so that porting from conservative to top performance be
as simple as possible, and even more important, so that running on conservative
or top performance be transparent for applications.

That's the second point where current model starts to fall short:
we need planned changed in user land interface (/proc, ifconfig, etc)
in both kernels because no change in stable kernel view from user land is
probably also not a good idea because it will make it unusable at some
point because applications that upgraded will not run fine on it anymore,
and upgrading applications is mandatory also because of security issues;
not talking about improvements that can also append in the core conservative
kernel because finding the simplest implementation is not easy, so takes
time.

So, we end with:
. two lines (conservative and high performance),
. a set of patches in each line pending in the unstable queue
. a set of patches in each line pending in the API change queue

Now you understand why I post right now. If you are designing a patch
handling tool, then it's time to think how to handle the all new picture
to get back in sync with users.

Now, on the other hand, if we remain with the current development model,
my bet is what will append is:
>From years, I've red staight forward messages such as 'Linux is more reliable
than Windows', but the question is: What Windows ?
If you talk about comodity hardware, this is true because Microsoft will never
publish informations such as: don't use this hardware, their driver is poor
and it will bring the all kernel down (what they can't publish in facts since
they have not necessary access to the source code).
On the other hand, you can buy reliable Windows system provided you pay it
10 times the price of comodity hardware because then the hardware provider
will have gone through serious auditing and testing of all peaces.
Now, the big problem is that to some extend, the Linux success with it's
corolary of Linux high profile developpers beeing given high end machines,
and Linux mainly focusing on top performances, is that this might come true
in Linux world also fairly soon.
Open development made it possible to fairly easily select the right hardware
in the 2.0 days, and get a top stable box, but with 2.6, complexity is 
something you can't avoid, so TCP issue as an example is something you won't
get easily rid of, and complex locking is something that makes many peaces
silently switch from absolutely stable to mostly stable, so that more
testing is needed.

