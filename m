Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTJaTaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTJaTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:30:30 -0500
Received: from thunk.org ([140.239.227.29]:46483 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263523AbTJaTa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:30:27 -0500
Date: Fri, 31 Oct 2003 14:30:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031031193016.GA1546@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030174809.GA10209@thunk.org> <3FA16545.6070704@namesys.com> <20031030203146.GA10653@thunk.org> <3FA211D3.2020008@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA211D3.2020008@namesys.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 10:40:03AM +0300, Hans Reiser wrote:
> Special cases of general theorems are not more powerful than the general 
> theorems, they are simply special cases.   You can design a language 
> that has the power of both relational algebra and boolean algebra.

Just because you can reduce everything to a turing machine doesn't
mean that the best way to implement a filesystem is with an infinitely
long tape which can only contain zero's and one's.  There are plenty
of optimizations which means that you can quickly and with minimal
overhead do searches based on structured data, which is far, far more
difficult to do if you are doing unstructured searches.  (In fact, in
some cases, if you don't have structured data to distinguish between
the author and the subject, you have to do the equivalent of natural
language processing if you are trying to do via an unstructured search
to find all papers written *about* a famous author, while not getting
false hits that were *written* by that same famous author.  Doing this
requires structured, not unstructured data.)

> >No, but it means that doing searches on formatted text is very
> >difficult,
> >
> When you say formatted text, do you mean fonts and stuff, or do you mean 
> object storage models.  Object storage models should generally be 
> replaced with files and directories. 

I mean fonts and stuff.  Stripping out fonts, tables, etc. for doing
generalized, unstructured text search, clearly needs to be done in
userspace.  Actually, I think we both agree on this point.  The poing
of disagreement is whether the searches utilizing such indexes should
be done in the kernel as part of the intrinsic part of the filesystem,
or in userspace.  I believe that we need to draw a very firm line
between what you call "primary keys", which uniquely identify a file,
and generalized searches.  You believe the two should be unified.

> Are you saying that auto-indexers should not parse the formatted text, 
> index the document, and allow users to find the document, with the 
> auto-indexer running in user space, but the indexes being traversed by 
> the filesystem namespace resolver?  The kernel does not need to 
> understand how to parse a document, it just needs to support queries 
> that use the indexes created by an auto-indexer that does understand it.

I believe that there is a big difference between, "I want the file
named /home/tytso/src/e2fsprogs/e2fsck/e2fsck.c", and "I remember
vaguely that 5 years ago, I read a paper about the effects of high-fat
diets on akida's, where the first name of the author was Tom".  The
first is a filename lookup.  The second is a search.  I would like
better search tools for files in a filesystem, no doubt.  But I would
never, ever put a search that might return an ambiguous number of
responses (that might change over time as more files are added to the
filesystem) in a Makefile as a source file.  

You are conflating these two concepts, pointing out that filename path
resolution happens a lot, and so therefore generalized searches should
also be done in the kernel.  What I am saying is that generalized
searches where the user needs to look at the returned set of files,
and then apply human intelligence to see which of the returned set of
files was the one they were looking for is a FUNDAMENTALLY DIFFERENT
OPERATION from a filename lookup via a primary key.  The latter should
be done in the kernel, as is the case to day.  The former should by no
means be in the kernel, and should be done in userspace, preferably
with a graphical interface lookup so the user can look at the returned
files, look at the context in which the search parameters appear, and
select the ones which actually is the document they were looking for.

Sure, Google has the concept of the "I'm feeling lucky" button.  But
there is a fundamental difference between a URL, and saying, "Type
'Akida fat diet' into Google and hit "I'm feeling lucky".  The latter
is something that you would never put into hypertext document as a
link, because it changes over time, and what works today might not
work tomorrow.  That is the difference between a name (a URL), and a
search string (what you type into Google).

> >In contrast, consider searching for someone who is male, between 30
> >and 40, is named Tom, and lived in Libertyville, Illinois sometime
> >between 1960 and 1970, and is married to someone named Mary who was
> >born in California.  This might return several people, and most people
> >would **NOT** consider the space of all queries about people to be a
> >"name space". 
> >
> Oh god, did you read the literature?

Is this the same literature as the ones which said that Microkernels
were the way, the truth and the light?  Is this the same literature as
the stuff written by the Professor Tennenbaum, who said he would have
given Linus a failing grade if he submitted Linux as a project?  There
are plenty of things in the Literature that I consider to be pure
stuff and nonsense, and people who claim that searches and "name
spaces" to be identical fall into that category as far as I'm
concerned....

> >Searches are not names.  They do not uniquely identify
> >people or objects, which is a fundamental requirement of a name.
> > 
> >
> You mean like Theodore?  Are you saying that Theodore is not a name 
> because it does not uniquely identify you?

In the computer science usage, yes, "Theodore" is not a name.  It is a
nick name; it is a convenient handle by which I can be identified; but
it does not uniquely identify me.  (I am reminded of a story from when
I was at MIT, and someone called up a fraternity, Tau Epsilon Theta,
and asked for "Mike", and was told, "which one".  "Well, the one which
lives at Tep".  "There's more than one".  "Well, the one with blond
hair".  "Sorry, there are three Mikes with Blond hair at TEP".  The
result was a run of frat shirts that were labelled, "Blond Mike from
TEP".  The moral of the story?  "Mike" is not a useful name when
trying to contact a specific person at this specific fraternity at MIT
back in the late 80's.)

> >The bottom line is that for something that happens dozens or even
> >hundreds of times a day, that's an argument that it *shouldn't* be
> >done in the kernel.  Compare and contrast that with handling incoming
> >network packets, which can happen millions of times per hour.
> > 
> >
> Actually the relevant measure is, not how often do you use it, but how 
> often would it context switch if it was not in the kernel.  Users rarely 
> use the networking code directly.

If random generic searches that return an ambiguous number of matches,
some of which may be the one the user wants, and some of them not,
happens only a few dozen times a day (which is about how often I use
Google), then an extra context switch, which is really fast in Linux,
is completely lost in the noise.  

> Naming is used by programs a lot.  Enhace naming, and the programs will 
> used enhanced naming a lot.

Searching and Naming are not the same thing.  Period.

						- Ted
