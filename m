Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTEPRxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTEPRxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:53:34 -0400
Received: from [216.239.30.242] ([216.239.30.242]:36366 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP id S263339AbTEPRx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:53:27 -0400
Message-Id: <200305161805.h4GI5buN032216@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Fri, 16 May 2003 13:05:36 -0500
In-Reply-To: Linus Torvalds <torvalds@transmeta.com>
       "Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2" (May 15, 10:23am)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@warthog.cambridge.redhat.com>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Cc: Dean Anderson <dean@av8.com>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 10:23am, Linus Torvalds wrote:
} Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2

Good morning to everyone discussing this fascinating topic.  I've been
reading it for a day or two before joining in.  There have been some
excellent points made and I won't even try to paraphrase all of them.
I am including a snippet from what I consider the 'Linus definitive
statement' on this issue since this is the definitive focal point
which discussion must come down to.

I think the issue comes down to whether or not Linux will incorporate
functionality for the sake of correctness vs. expediency.  Based on
all the history I think that everyone generally assumes that doing
things correctly is the preferable route.

In this case doing things the 'correct' way also provide the potential
opportunity for Linux to do something reasonably creative.  I've been
banging on issues with respect to identity management and Linux since
about 1998 and it is now interesting to see these issues becoming
pragmatically relevant.

Technical thoughts follow below.

> Independent joins are a _requirement_.
> 
> My take on this is that I'm personally totally uninterested in AFS and 
> Kerberos. 
> 
> What I _am_ interested in is things like per-user VPN keys, and things
> like keeping my local harddisk encrypted.
> 
> So myt background is that unless the credentials are useful for something 
> like that, then they aren't useful AT ALL.
> 
> With a local encryption, what I'm perfectly willing to do is to go through
> a "strong authentication" once, but once I've done that, I don't want to
> do it again every time I log in to that machine. I use ssh all the time,
> and I have a few machines I trust, so when I come in from such a trusted
> machine, and the strong authentication session is already in progress, I
> don't want to see a password or anything like that. It should "just
> work".

I apologize if this solution seems somewhat off the wall but I have
been working on these issues through the Hurderos Project since about
1998.  Based on experience from lots of miles I think that solving
these issues require thinking that is somewhat out of the box.

Based on Linus' requirements it would seem that we should be thinking
about implementing something which I would refer to as an 'identity
services' cache in the kernel.  I believe that this approach would
have the advantage of satisfying Linus' vision for a solution of
grander scale while satiating the pragmatic concerns of those in the
AFS camp.

	An aside to David Howells:  I actually started a round of
	conversations with Tiemann about some of this work and these
	issues about 18 months ago.  He indicated interest but since
	then there has been nothing but a blackhole from RedHat.  I
	would be happy in working with you or anyone else that is
	interested in creative solutions in this space.

An identity services cache would essentially implement a data
structure representing the 'intrinsic' identity of each user on the
system.  Tied to this 'identity' would be data structures which would
implement multiple authentication/authorization (auth/authz) services
for the intrinsic user identity.  Put in another way these 'services'
would handle the problem of managing multiple representational
identities which is essentially what the multi-credential problem
boils down to.

In the above model a PAG essentially becomes one of many services
which are linked to the intrinsic identity of the user.  The AFS group
would simply implement a 'PAG service' which can be orthogonal to any
other representational identity, ie authentication scheme, in use by a
user.  This strategy allows AFS to continue to work within the context
of a PAG while not imposing limitations on the type or nature of any
other credentialling system.  This system is also conceptually and
notionally consistent with PAM, which would seem to be important from
the thoughts offered by Linus.

What is needed from the kernel perspective are system calls which
manage the user's intrinsic identity and the 'services' attached to
them.  The following spring to mind quickly:

	1.) Create an entry in the identity cache.

	2.) Query for and return an entry in the identity cache.

	3.) Delete an entry from the identity cache.

	4.) Create a credentials service for an identity.

	5.) Delete a credentials service for an identity.

	6.) Specify the default set of credential services that are in
	    effect for a process.

	7.) etc., etc., etc

I would envision that an entry in the identity services cache would
persist as long as there was a process that referenced the identity.

I suppose that there is the potential arguement that once an identity
was instantiated it should exist until it is explicitly destroyed.
There is probably plenty to cogitate on that issue alone.  One could
also envision instances of credential services cleaning up and
releasing themselves from their identity when something like an
expiration time was exceeded.

I would suggest that cooperativity between the credential services
would also go a long ways toward solving the joining problems and some
of the other issues that we have discussed.  Lets take classic PAG as
an example:

	Linus logs in using SSH to a server which has been configured
	to use a Kerberos PAM module.  After authentication an
	additional module checks to see whether or not his identity
	exists in the identity services cache, if not an entry is
	created.  A call is then made to attach a KERBEROS credential
	service to his identity with the credentials which were
	obtained through the authentication process.

	Later in the session he decides to view the working plans for
	the 64 bit extensions to the ix86 instruction set that
	Transmeta is working on under NDA with Intel... :-) Since the
	documents are on an AFS volume the client creates and attaches
	a PAG credential service to his identity.  During
	initialization the PAG service checks the identity cache to
	see if a KERBEROS credential service is availabe.  If so it
	either copies or links to the credentials and uses them.

	Later in the session he decides to check the work that the
	OpenAFS team is doing on the PAG service module.  He issues
	the appropriate command to obtain his credentials in the
	OpenAFS cell.  The pagsh command or whatever he uses checks to
	see whether or not a PAG service exists.  If it does it issues
	the appropriate calls to overlay his current AFS credential
	set.  Thoughout all this his credentials maintained by the
	KERBEROS identity service remain intact since AFS itself is
	only dealing with the PAG identity service.

Now this is admittedly a very contrived example but I hope it
represents the thinking behind the model.

I would be interested in any thoughts or ideas that others have on
this issue.  It is somewhat off the wall but as I mentioned before I
think that this is a case where Linus is looking for something with
large amounts of flexibility in design which doesn't lock the concept
of credential management to one particular application.

Huge amounts of detail to fill in however.

At the very minimum there will have to be defined interfaces for
various tasks that the identity services module will be expected to
offer to the kernel.  One example that comes to mind is what happens
to in various credential service types when the user wishes to change
identities.  Perhaps an even bigger question is whether or not the
seteuid() call attaches the process to the target users identity
services cache or maintains the 'real' one.

> 			Linus

I would be interested in thoughts/comments.

Best wishes for a pleasant weekend everyone.

Greg

}-- End of excerpt from Linus Torvalds

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"My thoughts on trusting Open-Source?  A quote I once saw said it
best: 'Remember, Amateurs built the ark.  Professionals built the
Titanic.'  Perhaps most significantly the ark was one guy, there were
no doubt committees involved with the Titanic project."
                                -- Dr. G.W. Wettstein
                                   Resurrection
