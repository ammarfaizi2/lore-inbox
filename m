Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUINEZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUINEZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUINEZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:25:37 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:43419 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S268892AbUINEZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:25:09 -0400
Message-ID: <41467339.4050205@myrealbox.com>
Date: Tue, 14 Sep 2004 00:27:37 -0400
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: file-as-dir vs. dir? (was Re: silent semantic changes with reiser4)
References: <20040824202521.GA26705@lst.de>
In-Reply-To: <20040824202521.GA26705@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Apologies for beating on a dead horse here...)

I seems like one confusion here is that everyone has a different idea of 
what the semantics we're talking about are.  I see two main ones:

Hans's: A file, a directory, and an attribute are functionally 
equivalent (except for S_ISxxx and hardlinks).  That is, /usr/bin/metas 
makes sense, and it's not talking about a program called metas.  This 
also means that /foo/metas/metas might exist and needs dealing with.

Linus's (I think):  A directory is just a directory (no attributes and 
no read()able data).  A file can contain attributes, where attributes 
can be "file" attributes or "directory" attributes.  That is, a file is 
also a subtree with posix-like semantics (except for hardlink stuff). 
So doing "touch /tmp/foo; cat /tmp/foo/metas" fails, rather than doing 
something that's probably useless.  "touch /tmp/foo; touch /tmp/foo/bar; 
touch /tmp/foo/bar/baz" fails on the last touch because bar is a file 
attribute and recursive magic is disallowed.

Which one are we talking about?

FWIW, I like the latter version a lot better, as it removes a lot of 
ambiguity.  If I see a path like /tmp/foo/metas/uid, it is either a uid 
attribute (i.e. writing it has security implications) or it is a 
standard file (i.e. writing it  just writes it).  But _I can tell which 
one_ by fstat()ing /tmp/foo!  If it's a directory, than I have either a 
named stream called uid or a genuine file called uid (and I can tell 
which by fstat()ing /tmp/foo/metas), but if it's a file then I have the 
magic uid.  And I'm guaranteed that there's no other funny business, 
because /tmp/foo is a "file with a subtree," which means that it's not 
an attribute.  This way I know exactly what I'm dealing with.

As an added bonus, we could have O_NOMETAS which means that "files" may 
not be traversed.  Then someone who wants to make sure they get a real 
file can do it.  If recursive files-as-dirs were allowed, that might not 
do quite what the caller expected.  If you really wanted a directory 
with some data attached, but it in dir/.mystuff, because that's probably 
what you meant, and any existing tool will do exactly the right thing 
with it.

In the former version, AFAIK, I have a mess.  In UNIX, a path is a path. 
  It's trivial to understand and there's no funny business parsing it. 
But now a path has a slippery meaning where the token "metas" could be a 
plain old token or it could be magic or it could be magic some other 
way.  The security implications and the possbility for something to 
break horribly are scary.

--Andy
