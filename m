Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbREYWfC>; Fri, 25 May 2001 18:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREYWew>; Fri, 25 May 2001 18:34:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58200 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261987AbREYWer>; Fri, 25 May 2001 18:34:47 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.LNX.4.31.0105251417070.7867-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 May 2001 16:31:37 -0600
In-Reply-To: Linus Torvalds's message of "Fri, 25 May 2001 14:18:31 -0700 (PDT)"
Message-ID: <m11ypdgiwm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 25 May 2001, Eric W. Biederman wrote:
> >
> > I obviously picked a bad name, and a bad place to start.
> > int data_uptodate(struct page *page, unsigned offset, unsigned len)
> >
> > This is really an extension to PG_uptodate, not readpage.
> 
> Ugh.
> 
> The above is just horrible.

Useless and possibly excess maintence, but horrible?
Clean concepts and interfaces are horrible?

> It doesn't fix any problems, it is only an ugly work-around for a
> situation that never happens in real life. 

An ugly work around?  If exposing the details of what happens during
a partial write is ugly, then I submit we have issues.  

Changing 
	if (!Page_Uptodate(page)) ....
to
	if (!Page_Uptodate(page) && !data_uptodate(page, offset, nr)) ..

In one or two places that really only need partial page data
should be trivial, and clean.  Probably less than 100 lines for the
whole implementation.

> An application that only
> re-reads the data that it just wrote itself is a _stupid_ application, and
> I'm absolutely not interested in having a new interface that is useless
> for everything _but_ such a stupid application.

Problem:
Reading from memory is always faster from reading from disk.
We already have all the information we need to check to see if something is
actually in memory.  We just don't have a way to get at it.  So we do
extra I/O to no benefit.

The case where this comes up all of the time is the tail of files.  We
happen to be able to set PG_Uptodate in these cases, today, so it
probably isn't a big deal.   A lot of this I can imagine getting worse
as PAGE_CACHE_SIZE gets bigger.  

Usefulness: 
That is hard to tell.  The idea is general and clean.  It
fits in nicely with reading and writing partial pages.  So anytime we
have that case it could come in handy.

But I do agree the good implementation would probably to extend buffer
heads so that they can be used by network file systems for their
pending I/O.  Then we wouldn't need a virtual function, and could 
still find out if we have pages partially populated.  

I see this as a reduction in cache misses at very little cost.  And as
such probably worth it.  If the code maintenance or number of lines is
two high, then it probably isn't worth it. 

Applications:
But any application that reads/writes to a Btree.  With the Btree page
size being smaller than PAGE_CACHE_SIZE I can see this happening to.  
For Btree's you traverse the tree multiple times, in a row.  You have
no clue what your locality is going to be, and no way to predict which
page you are going to traverse into next.  Btrees are designed to
minimize the number of I/O's so taking a preventable I/O not likely
a big deal, but what is the point of using the OS's caching mechanism
if it doesn't help?

And I can think of other cases where you are doing random I/O in
on database type records, and happen to get locality because you have
multiple transactions dealing with the same data because you are doing
multiple things to a single persons account.  Now normally you will
have the read/modify write case, but occasionally you will be adding
new records and have the write and then read modify write cases.

So no I don't think it is only stupid applications that will trigger
these cases.  Simply applications that are prone to random I/O and
know the OS does a decent job of caching so haven't written their own
caching layer.  And they happen to have records that are smaller than
the application page size.

In unix we don't get a lot of this because we tend to use ascii based
files, with small data sets where it is cheaper to read the whole file
into memory at once.   With a larger data sets the tradeoffs become
different.  /etc/passwd on a system with 100's of thousands of users
is a classic example, of these tradeoffs changing.  

So a non stupid application would just need to add a user to
/etc/passwd.db and then set their password, and change their login
shell.  To trigger unexpected locality, in a random I/O case.   With
enough ram this could be within a period of a couple of minutes.  When
the administrator is setting up an account.

Eric
