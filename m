Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVAYV1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVAYV1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVAYV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:26:26 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:11474 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262132AbVAYVUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:20:07 -0500
Message-ID: <41F6B80C.1080401@comcast.net>
Date: Tue, 25 Jan 2005 16:20:12 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>  <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>  <41F6604B.4090905@tmr.com>  <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>  <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net>  <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>  <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com> <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



linux-os wrote:
> On Tue, 25 Jan 2005, John Richard Moser wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> Dmitry Torokhov wrote:
>>
>>> On Tue, 25 Jan 2005 13:37:10 -0500, John Richard Moser
>>> <nigelenki@comcast.net> wrote:
>>>
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>>
>>>> Linus Torvalds wrote:
>>>>
>>>>> On Tue, 25 Jan 2005, John Richard Moser wrote:
>>>>>
>>>>>
>>>>>> It's kind of like locking your front door, or your back door.  If
>>>>>> one is
>>>>>> locked and the other other is still wide open, then you might as well
>>>>>> not even have doors.  If you lock both, then you (finally) create a
>>>>>> problem for an intruder.
>>>>>>
>>>>>> That is to say, patch A will apply and work without B; patch B will
>>>>>> apply and work without patch A; but there's no real gain from using
>>>>>> either without the other.
>>>>>
>>>>>
>>>>>
>>>>> Sure there is. There's the gain that if you lock the front door but
>>>>> not
>>>>> the back door, somebody who goes door-to-door, opportunistically
>>>>> knocking
>>>>> on them and testing them, _will_ be discouraged by locking the
>>>>> front door.
>>>>>
>>>>
>>>> In the real world yes.  On the computer, the front and back doors are
>>>> half-consumed by a short-path wormhole that places them right next to
>>>> eachother, so not really.  :)
>>>>
>>>
>>>
>>> Then one might argue that doing any security patches is meaningless
>>> because, as with bugs, there will always be some other hole not
>>> covered by both A and B so why bother?
>>>
>>
>> I'm not talking about bugs, I'm talking about mitigation of unknown bugs.
>>
>> You have to remember that I think mostly in terms of proactive security.
>> If there's a buffer overflow, temp file race condition, code injection
>> or ret2libc in a userspace program, it can be stopped.  this narrows
>> down what exploits an attacker can actually use.
>>
>> This puts pressure on the attacker; he has to find a bug, write an
>> exploit, and find an opportunity to use it before a patch is written and
>> applied to fix the exploit.  If say 80% of exploits are suddenly
>> non-exploitable, then he's left with mostly very short windows that are
>> far and few, and thus may be beyond his level of UNION(task->skill,
>> task->luck) in many cases.
>>
>> Thus, by having fewer exploits available, fewer successful attacks
>> should happen due to the laws of probability.  So the goal becomes to
>> fix as many bugs as possible, but also to mitigate the ones we don't
>> know about.  To truly mitigate any security flaw, we must make a
>> non-circumventable protection.
>>
> 
> So you intend to make so many changes to the kernel that a
> previously thought-out exploit may no longer be workable?
> 
> A preemptive strike, so to speak? No thanks, to quote Frank
> Lanza of L3 communications; "Better is the enemy of good enough."
> 

No, like this.

You have a race condition, let's say.  This is fairly common.  Race
conditions work because you generate a unique tempfile directory, create
it, check to see if this tempfile exists in it, it doesn't, so you
create it.  Problem is, someone's symlinked or hardlinked another file
into that temp directory, which you can write to but they can't; and you
wind up opening the file and trashing it, or erasing it by creating over it.

So, simple fix.

1)  If the directory is +t,o+w, and the symlink is not owned by you, and
the symlink is not owned by the owner of the directory, you can't follow
the symlink.
2)  If you try to make a hardlink (ln) to a file you don't own,
permission is denied, unless you've got CAP_FOWNER and uid==0.

Now, root tries to traverse /tmp/root/tmp4938.193a -> /etc/fstab, and
gets permission denied.

This is a real solution to race conditions (it's in GrSecurity).  It's
not "so many changes that previously thought-out exploits are no longer
workable," it's a change in policy to remove conditions necessary for
any future exploit of this class to be workable.

>> If you can circumvent protection A by simply using attack B* to disable
>> protection A to do more interesting attack A*, then protection A is
>> smoke and mirrors.  If you have protection B that stops B*, but can be
>> circumvented by A*, then deploying A and B will reciprocate and prevent
>> both A* and B*, creating a protection scheme that can't be circumvented.
>>
> 
> It makes sense to add incremental improvements to security as
> part of the normal maturation of a product. It does not make
> sense to dump a new pile of snakes in the front yard because
> that might keep the burglars away.

Snakes like passwords, or like a DAC system, or like SELinux MAC
policies, or like preventing tasks from reading or altering eachothers'
memory space?

> 
>> In this context, it doesn't make sense to deploy a protection A or B
>> without the companion protection, which is what I meant.  You're
>> thinking of fixing specific bugs; this is good and very important (as
>> effective proactive security BREAKS things that are buggy), but there is
>> a better way to create a more secure environment.  Fixing the bugs
>> increases the quality of the product, while adding protections makes
>> them durable enough to withstand attacks targetting their own flaws.
>>
> 
> Adding protections for which no known threat exists is a waste of
> time, effort, and adds to the kernel size. If you connect a machine
> to a network, it can always get hit with so many broadcast packets
> that it has little available CPU time to do useful work. Do we
> add a network throttle to avoid this? If so, then you will hurt
> somebody's performance on a quiet network. Everything done in
> the name of "security" has its cost. The cost is almost always
> much more than advertised or anticipated.
> 
>> Try reading through (shameless plug)
>> http://www.ubuntulinux.org/wiki/USNAnalysis and then try to understand
>> where I'm coming from.
>>
> 
> This isn't relevant at all. The Navy doesn't have any secure
> systems connected to a network to which any hackers could connect.

BUT MY HOME COMPUTER IS CONNECTED TO A NETWORK FROM WHICH I COULD GET A
WORM :D :D :D

And there could be an insider in the navy trying to get higher access
than he has.

> The TDRS communications satellites provide secure channels
> that are disassembled on-board. Some ATM-slot, after decryption
> is fed to a LAN so the sailors can have an Internet connection
> for their lap-tops. The data took the same paths, but it's
> completely independent and can't get mixed up no matter how
> hard a hacker tries.
> 

So, what?

Your solution is that it doesn't matter that exploits exist because
wherever it matters, other things in the environment will stop them?
I.e. you're just an ass?

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9rgMhDd4aOud5P8RAnfjAJ40L6GvhTLunbVKdF16VOv66vZpQQCgh8hz
9yZDc5h8hK13yfvnB9z3R7E=
=IL8i
-----END PGP SIGNATURE-----
