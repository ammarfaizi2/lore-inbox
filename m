Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSICFBU>; Tue, 3 Sep 2002 01:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318709AbSICFBU>; Tue, 3 Sep 2002 01:01:20 -0400
Received: from moremagic.merlins.org ([204.80.101.251]:7662 "EHLO
	mail2.merlins.org") by vger.kernel.org with ESMTP
	id <S318708AbSICFBR>; Tue, 3 Sep 2002 01:01:17 -0400
Date: Mon, 2 Sep 2002 22:05:04 -0700
From: Marc MERLIN <marc_news@merlins.org>
To: matti.aarnio@zmailer.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20020903050504.GK6579@merlins.org>
References: <20020903001509.E22256@sventech.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20020903001509.E22256@sventech.com>
User-Agent: Mutt/1.3.28i
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Operating-System: Proudly running Linux 2.4.14-lvm1.0.1rc4-ext3-0.9.15-servers11-up/Debian woody
X-Mailer: Some Outlooks can't quote properly without this header
Subject: Re: Stupid anti-spam testings...
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Philip Hazel bcced]
[Blue-labs postmaster bcced too]

From: Matti Aarnio <matti.aarnio@zmailer.org>
> On Mon, Sep 02, 2002 at 04:28:37PM -0600, Andreas Dilger wrote:
> ...

Hi folks. Since I've been involved in code in exim, spamassassin, and was
the postmaster for sf.net, I thought I could give some info on all this.

> > > Folks,  when you deploy that kind of testers, DO VERIFY THAT THEY
> > > HAVE SANE CACHES!  A positive result shall be cached for at least
> > > two hours, a negative result shall be cached for at least 30 minutes.
> > 
> > Do you know if this is one of the default checks from spamassassin?
 
There  is no  code in  spamassassin  that does  SMTP callbacks  and I  would
advocate against it if someone were to think about adding it. Callbacks need
to be  done once,  at SMTP  time, not  later for  each receipient  when it's
already too late to bounce the mail if the env from is non reachable.
 
>   No idea.  I have seen these coming from Exim 4.10, Exim-something,
>   some sendmail milter (whatever that is), etc..

Ok.
So, exim, has  since version 3.2x (I think, might  be 3.3x) something called
SMTP callbacks (now SMTP callouts).
It's an optional  feature where the server does a  NULL SMTP connection back
to the  envelope and header  sender to make sure  that the servers  would be
willing to accept mail back for those.

Goals are:
1) do not accept mail that you cannot bounce (i.e. limit dead mail/double
   bounces in your spool)
2) make sure that mail you accept can be answered (bad header from)
3) Tell  people that  their envelope  is  broken (you  can only  do that  by
   rejecting the SMTP connection)
4) Refuse mail from morons who refuse null MAIL FROMs
5) and that's only a byproduct: refuse some junk mail/spam

If you want to know how it works in details, I've explained it here:
http://sourceforge.net/docman/display_doc.php?docid=6747&group_id=1 

I think someone may eventually have written an SMTP milter to do the same
(I suggested it to Eric Allman when he talked at SVLUG last year)

>   Apparently the idea (which I have thought of long ago, and rejected
>   as incomplete) has caught, and has multiple implementations...

Not too many yet, and it is turned off by default on exim, however many are
turning it on (for better or for worse)

>   I can easily reduce the load impact it causes to vger by
>   running the smtp server in "accept everything" mode without
>   analyzing local addresses for existence.  With a bit more
>   work I can throw in local cache..  (which I probably have to do..)
 
Hopefully it won't come to that.
 
> > If it is possible to track what tool is causing the problem and fixing
> > the default setup of that tool at the source, it will probably solve
> > 99% of the problems in one go (after the list knows to which version
> > they should upgrade).

As soon  as Philip Hazel initially  came up with the  first implementation I
know  in exim,  I  suggested to  him  that he  should  _really_ implement  a
positive and negative cache.
Worse, if the header  and envelope from are the same,  the current code will
still open  two SMTP connections back  to check them both,  even though they
are equal

Unfortunately Philip hasn't had the time to implement this yet, and others
(like me) haven't had the time to do it either and contribute code back.

>   Raise some noise all around, there are multiple implementations
>   of the idea.  Some even with syntactically invalid tester codes
>   (spaces put in place where they don't belong in RFC 821/2821);
>   "works with sendmail" is NOT synonymous to "is syntactically 
>   correct."

I only know of the exim implementation, and I believe that one is correct.

>   - a mister at blue-labs.org  runs some sendmail-milter which
>     does testing with invalid protocol syntax

I think I know who it is, he may have written it after he saw the code I put
on sf.net, or he may have gotten it from somewhere else, I'll let him know.

>   - usw-sf-list1.sourceforge.net  use probably their own code
>     usw-sf-fw2.sourceforge.net too...  possibly more systems there..

I don't remember the  network layout, and it may have  changed since I left,
but mail  goes to  one host  which then dispatches  it to  sf lists  or some
users.sf.net alias.
I did  change the  code a  little bit  on lists.sf.net  to do  an additional
postmaster callback  because we got  tired of  having to support  people who
filled our  spool with crap and  didn't accept Email for  postmaster when we
tried to contact them and work things out.
The code uses the existing SMTP connection,  so it issues an extra RCPT, but
that's very little extra load.

Note  too that  users.sf.net users  aren't really  supposed to  subscribe to
mailing  lists  with  those  aliases. The users.sf.net  alias  is  simply  a
redirector you can use and advertize for your projects.
Now in  practise, some  sf.net users are  apparently subscribing  to mailing
lists anyway, but the mail server wasn't designed with that in mind.

Please note too  that I am not  employed by VA Software anymore,  so you can
flame  me,  but  I  won't  be  able  to  do  much  to  fix  it. I  know  the
implementation is imperfect,  I was only postmaster for sf.net  on my "spare
time" since no one else was there to do  it, but it was the best we could do
to handle junk mail, bad bounces,  and spam send to several hundred thousand
users all running on mail server, and with no full time mail admin.
I know some things  that can be done, I'll list a few  here, but I never got
to upgrade to exim 4 with a  callback exclude setup (doable with exim 3 too)
because I  was layed off a  couple of weeks  before I'd have rolled  out the
implementation.

To contact the sf.net team, you can submit a sf.net support request here:
https://sourceforge.net/tracker/?func=add&group_id=1&atid=200001
If you  are not satisfied,  you can also contact  the site director  at this
address: pat@sf.net

>   - quetz.demon.co.uk tests from  Exim 4.10
>   - somebody.symons.net tests from Exim 3.35
 
I'm surprized you're not seeing more exim users.
 
>   Right now something like 5-7 different systems are doing it.
>   Try to imagine when all 3500 targets do it...  BRRRRR...
>   (Sure, VGER can handle it, no problem, but it is that much
>    wasted cycles, and network traffic...)

Ok, so here's my opinion on this since I studied callbacks extensively
before rolling them out on sf.net and hacking the code:

1) we've had  3 or 4  complaints in 2 years,  mostly from people  who didn't
   like the extra lines in their mail logs
2) The SMTP callback does take a few resources, but they are rather minimal.
   If you  send lots  of mail,  you typically have  the resources  to handle
   callbacks from remote sites.
3) Yes, it can get  bad for a list server when  many receipients start doing
   it


What should be done about this:

1) Positive caching with a cache of at least a day, if not a week, should be
   in every SMTP callback implementation

2) I'm looking at setting up a DNS list of list servers so that people don't
   do callbacks on them. With exim 4, you could then query that list and not
   do callbacks if the sending list server's IP is in that list.
   Something can probably be done to exclude envelope from domains too.
   If you are willing to help me with this, let me know

3) A 3rd, and lesser solution, is to agree on a mail header that tells
   receiving servers not to do callbacks.
   a) can obviously  be faked by spammers,  but I still think  it'd work for
      quite  a while:  spammers  who  are smart  enough  already fake  valid
      envelope and header froms, so they wouldn't have to add the header
   b) exim can trivially add a header on outgoing mail and check for it
      before doing  callbacks on the  receiving side,  but I don't  know how
      trivial  it is  for other  MTAs  of sending  list servers  to add  the
      header.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking 
Home page: http://marc.merlins.org/   |   Finger marc_f@merlins.org for PGP key
