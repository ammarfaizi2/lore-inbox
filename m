Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbRFJTay>; Sun, 10 Jun 2001 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbRFJTao>; Sun, 10 Jun 2001 15:30:44 -0400
Received: from beasley.gator.com ([63.197.87.202]:15123 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S261616AbRFJTaj>; Sun, 10 Jun 2001 15:30:39 -0400
From: "George Bonser" <george@gator.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Sun, 10 Jun 2001 12:30:15 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIEKGDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0106100541200.1742-100000@duckman.distro.conectiva>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, new test.  Apache, no keepalives. 85 requests/sec for a 10K file
128MB of RAM Processor is UP 700MHz Intel

vanilla 2.4.6-pre2

After everything settles down I have about 230-250 apache process running.
about 4% of CPU in user and roughly 6% in system.

Top shows:

 18:12:47 up 59 min,  2 users,  load average: 1.36, 3.26, 12.76 <- from a
previous test,
240 processes: 239 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   3.7% user,   6.8% system,   0.0% nice,  89.5% idle
Mem:    127184K total,    95308K used,    31876K free,    14300K buffers
Swap:   498004K total,     5032K used,   492972K free,    14244K cached

I have about 5MB in swap.

Now kick off make -j8 in the linux kernel tree.  CPU goes to about 80/20
user/system
Top looks like this:

 18:21:46 up  1:08,  2 users,  load average: 17.71, 12.19, 12.55
299 processes: 290 sleeping, 9 running, 0 zombie, 0 stopped
CPU states:  77.4% user,  22.6% system,   0.0% nice,   0.0% idle
Mem:    127184K total,   124664K used,     2520K free,     2644K buffers
Swap:   498004K total,    20160K used,   477844K free,    11612K cached

So I have pushed about 20M into swap with a really busy system (SCSI ext2)

I run make -j8 in the source tree and am able to get the machine in a state
where it is no longer interactive at the terminal, it seems to be hung, the
make is generating nothing, top is not refreshing, machine responds to pings
fine.  Last top refresh shows:

 18:26:41 up  1:13,  3 users,  load average: 39.39, 19.70, 14.99
393 processes: 383 sleeping, 10 running, 0 zombie, 0 stopped
CPU states:  39.6% user,  35.7% system,   0.0% nice,  24.7% idle
Mem:    127184K total,   123244K used,     3940K free,     2880K buffers
Swap:   498004K total,    34504K used,   463500K free,    26332K cached

I wait about 5 mintes to be sure I am not going to get anything back any
time soon.
Send cntl-c to the make, it takes abot a minute to quit. top starts
refreshing and
looks like this:

 18:31:55 up  1:19,  3 users,  load average: 228.76, 167.10, 80.71
331 processes: 330 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   1.3% user,  27.7% system,   0.0% nice,  71.0% idle
Mem:    127184K total,    87804K used,    39380K free,     3184K buffers
Swap:   498004K total,    31776K used,   466228K free,    24856K cached

If I try again to run the make -j8 I can not seem to get it to "hang" again.
Figuring it now has something cached that it can get to, I move to a
different source tree and run another make -j and it hangs again in a
different spot but with the same symptoms.

So much for vanilla 2.4.6-pre2. I shut down and reboot into 2.4.6-pre2+Rik's
patch.
After everything settles down top shows:

 19:07:32 up 12 min,  2 users,  load average: 0.08, 0.05, 0.00
300 processes: 297 sleeping, 1 running, 2 zombie, 0 stopped
CPU states:   5.3% user,   6.7% system,   0.0% nice,  88.0% idle
Mem:    127028K total,   106788K used,    20240K free,     1144K buffers
Swap:   498004K total,        0K used,   498004K free,    27408K cached

Hmmm, not in swap at all. Ok ... now lets kick off a make -j8

CPU goes to 85/15 user/system  about a 5% difference from the vanilla
kernel.
About 20MB into swap and the compile is progressing well.
Compile finishes with no hangup top looks like:

 19:13:19 up 18 min,  2 users,  load average: 2.80, 3.89, 1.85
259 processes: 258 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   3.7% user,   6.3% system,   0.0% nice,  90.0% idle
Mem:    127028K total,    87368K used,    39660K free,     1276K buffers
Swap:   498004K total,    17424K used,   480580K free,    34064K cached

So I pushed it about 17M into swap. Now let me move over to the other tree
and
build it just so it won't find anything cached that it can use :-) I am not
timing the compiles but they run faster under Rik's patch.

Second compile the system looks like this:

 19:18:28 up 23 min,  2 users,  load average: 8.21, 6.06, 3.23
257 processes: 251 sleeping, 6 running, 0 zombie, 0 stopped
CPU states:  24.1% user,   7.6% system,   0.0% nice,  68.2% idle
Mem:    127028K total,    78384K used,    48644K free,      976K buffers
Swap:   498004K total,    19760K used,   478244K free,    28992K cached

And it completes normally, no hangs. I can pretty much cause 2.4.6-pre2 to
"wedge"
(for lack of a better description) by just making it busy and having it do
something
that takes up swap. With Rik's patch everything stayed usable, interactive
response
was good and I could log in while the compile was running and got good
response
to the login prompts.

Several minutes after the last compile, things are pretty much back to
normal:

 19:26:14 up 30 min,  2 users,  load average: 0.02, 1.27, 1.94
266 processes: 265 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   3.7% user,   8.1% system,   0.0% nice,  88.2% idle
Mem:    127028K total,   103512K used,    23516K free,     1168K buffers
Swap:   498004K total,     7768K used,   490236K free,    38784K cached

I am going to run it a few days and see if anything breaks.

