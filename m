Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVBOIxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVBOIxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVBOIxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 03:53:18 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:58895 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261655AbVBOIxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 03:53:07 -0500
Message-ID: <4211B8FC.8000600@aitel.hist.no>
Date: Tue, 15 Feb 2005 09:55:24 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
In-Reply-To: <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Feb 14, 2005, at 20:17, Lee Revell wrote:
>
>> On Mon, 2005-02-14 at 16:16 -0800, Tim Bird wrote:
>>
>>> Lee Revell wrote:
>>>
>>>> But, I was referring more to things like GDM not being started 
>>>> until all
>>>> the other init scripts are done.  Why not start it first, and let the
>>>> network initialize while the user is logging in?
>>>
>>>
>>> There are a number of techniques used by CE vendors to get fast bootup
>>> time.  Some CE products boot Linux in under 1 second.  Sony's
>>> best Linux boot time in the lab (from power on to user space)
>>> was 148 milliseconds, on an ARM chip (running at 200 MHZ I believe).
>>
>>
>> The reason I marked by response OT is that the time from power on to
>> userspace does not seem to be a big problem.  It's the amount of time
>> from user space to presenting a login prompt that's way too long.  My
>> distro (Debian) runs all the init scripts one at a time, and GDM is the
>> last thing that gets run.  There is just no reason for this.  We should
>> start X and initialize the display and get the login prompt up there
>> ASAP, and let the system acquire the DHCP lease and start sendmail and
>> apache and get the date from the NTP server *in the background while I
>> am logging in*.  It's not rocket science.
>
>
> Such a system needs a drastically different bootup process than currently
> exists, including the ability to specify init-script dependencies.  (Like

The init-script dependencies are specifies already - at least on debian.
Look at the most used runlevel, ls /etc/rc2.d:

S10sysklogd@
S11klogd
S14ppp
S18portmap
S19slapd
S20alsa
S20cupsys
S20dhcp3-server
S20exim
...
The numbers specify ordering constraint, low numbers must start before 
high numbers.
But plenty of scripts have no interdependencies, I have 18 scripts 
numbered S20.
Today they start sequentially anyway, in alphabetical order.  Several of 
them simply
wait for hardware, which could be done in parallel.  So parallel 
execution would be a win.
One could always have a user-settable limit on how much to run in 
parallel, to help
out those low-memory machines. 

> for example user login via GDM (and with our setup, GDM working at all)
> requires that AFS is mounted and NIS is working, which both require the
> network to be available, which requires...  You can see where this is

Yes.  I don't think the X system will start before other things in a 
standard
installation, precisely because it *might* need the network and a bunch 
of other
things to validate the user.  So most of the gain will come from the 
parallel starting
of earlier scripts.
I think one can safely say that the xserver it won't need web, email
or the printer subsystems to get up though, and that could also save 
some time.

> going.  I think eventually we need a better /sbin/init, one that can use
> a traditional legacy /etc/inittab file in addition to a newfangled
> simultaneous boot process with lots of ways to start various kinds of
> services.  Unfortunately such a system will need a _LOT_ of work and
> testing to make sure it doesn't break existing setups.  Oh well, I can
> dream, can't I? :-D

It isn't all that hard.  An init with one change - scripts with the same 
number
runs in parallel instead of sequentially. (And possibly some 
configurable limit
on parallel scripts).  Then the rest of the work lies in an efficient 
and correct numbering of those
scripts.  The paranoid can renumber them so they run in the same
order as they used to.  Most people can use the existing numbering, 
perhaps they
discover an ordering bug or two which is trivially fixed using "mv" to 
renumber scripts.
And the more daring can renumber their scripts for maximum parallelism.

Even with today's system the goal of starting X early is achievable.  If you
know that X doesn't need the network on _your_ machine - renumber it to
start really early.  The modification is easy enough to do. :-)

If it still starts slow, swithc to a light session manager (like xdm) and
a lightweight window manager that doesn't bring in kde or gnome.

Helge Hafting



