Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVJDUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVJDUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVJDUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:11:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:42880 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964954AbVJDUL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:11:57 -0400
Message-ID: <4342E1A2.7080008@comcast.net>
Date: Tue, 04 Oct 2005 16:10:10 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <434204F8.2030209@comcast.net> <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>            <4342C9F1.2000005@comcast.net> <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>
In-Reply-To: <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Oct 2005 14:29:05 EDT, John Richard Moser said:
> 
> 
>>Aside from this, viruses and spyware and worms can now run rampant and
>>do what they want to his system, and other users' idiotic actions on a
>>multi-user system affect him.  This is more user friendly?  No, I think
>>it's going in the opposite direction. . . .
> 
> 
> Virus writers are users too, you know.  :)
> 
> And the other users are users as well - what if the other user's "idiotic
> action" is to nuke your 500Mbyte archive of alt.binaries.pictures.llama.sex
> that's taking up the disk space that is keeping him from running the payroll
> software?  In your world, rather than him being able to fix the problem, he has
> to go find a sysadmin with the root password to fix it, causing delays and
> being less friendly....
> 

Oh sure, except that. . .

1)  You shouldn't be screwing with the payroll system
2)  You're quota'd on any good setup
3)  You're fired

> You seem to be intentionally trying to miss the basic point, which is that
> any additional security ends up trading off against other things.
> 

It does, but put the degree to which it trades off in perspective.

Utilizing ProPolice, functions which contain a local character pointer
(char[]) are guarded.  These functions experience a minimal performance
hit; practically it can top-out at around 8% theoretical, although from
my perspective you could produce an empty function where the guard code
is 100% of its body.  The 8% theoretical is along the lines of:

void foo() {
  char a[6];
  strcpy(a, "hello");
}

Obviously strcpy()'s complexity decreases the overhead; this is some
strange hybrid of "theoretical maximum" with "practical maximum," which
comes out to be "theoretical practical maximum" which is nonsense, but
we'll just for the sake of discussion let that slide.

Anyway, a finite number of functions have such guard code; and the
overhead can be shown as a function y=1/x, where y is the overhead and x
is  the number of units of code run between entering and exiting the
function, assuming the code added by propolice is 1 unit.  In the end,
the overhead is pretty much nil for practical applications.

For your trade-off of some practical 0.1% increase in CPU load, your
applications do two things when a stack buffer is overflowed.  First,
they tell you what function produced the buffer that was overflowed, in
what source file; second, they immediately terminate (complain loudly).

This means that things that are fuzz may crash the program; but so will
attacks.  It also means that these crashes are easy to report in
valuable detail, and thus the bugs are fixed rather quickly.  In the
end, this produces cleaner, more stable code due to attention being
brought to bugs more directly.  Additionally, such bugs would cause
intermittent odd behavior ranging from things not working to program
freezes to data corruption; a sudden crash in place of these things is
hardly much of a trade-off.  Finally, deploying such a protection
doesn't suddenly unearth massive amounts of buggy code, because if there
were such bugs in force then there'd be massive amounts of odd behavior
already.

So you've traded nearly nothing in the practical sense for a great
enhancement in security in this example.  In some special applications,
a program with its own bug will trigger this, which may be a more major
trade-off; but you need access to the source code to add this protection
to anything anyway, so in this case it's just going to tell you how to
fix the bug anyway.

> Non-execute stack is a Good Thing security-wise - but it breaks some code,
> forcing upgrades and/or having to track down binaries and flag them as
> "don't enforce NX stack".  And then those binaries are still vulnerable....
> 

Right.  It breaks some (very little, typically) code.  Perspective please.

> SELinux is, in general, also a Good Thing.  However, the fact that the policy
> restricts what stuff can happen in the security context associated with
> mail delivery (after all, you *don't* want arbitrary binaries running then, right?)
> did some serious damage to the way I use procmail, which in some cases ended
> up running other binaries.  OK, so my .procmailrc *is* a 600-line monster that
> does a lot of odd stuff - the point was that I had to add even *more* contortions
> to the way it works, which is even less user-friendly....
> 

Special case that would have likely never arisen if you had such
restrictions when you started; or in the very least would have been
solved more elegantly.

> 

In the end, massive, intrusive security is not exactly the best thing
for security's sake; but anything you can get away with significantly
cleanly (i.e. you don't break 99% of the applications on 99% of home
users' desktops) is worth immediate focus for those who are so inclined.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDQuGhhDd4aOud5P8RAtbhAJ9p22xB3KhPQ9iywk7ug6VbAgKFlQCeN9Yp
si7fx6ngk4UU/H8KTNgeR0U=
=soXe
-----END PGP SIGNATURE-----
