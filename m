Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUDMOZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 10:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbUDMOZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 10:25:48 -0400
Received: from dhcp07.cobite.com ([208.222.80.37]:60072 "EHLO
	dhcp07.cobite.com") by vger.kernel.org with ESMTP id S263573AbUDMOZo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 10:25:44 -0400
Date: Tue, 13 Apr 2004 10:25:39 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@dhcp07.cobite.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS file handle cached incorrectly
In-Reply-To: <1081804045.7181.30.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0404121736070.23214@dhcp07.cobite.com>
References: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com> 
 <1081803713.7181.26.camel@lade.trondhjem.org> <1081804045.7181.30.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Trond Myklebust wrote:

> På m , 12/04/2004 klokka 14:01, skreiv Trond Myklebust:
> > The problem here is rather that you are making remote modifications to
> > the NFS server's directory within < 1second (which is the resolution on
> > "mtime" on Linux 2.4.x) of the previous modification. Linux (and all
> > other NFS clients that I'm aware of) uses the mtime in order to decide
> > whether or not a file/directory/... has been modified since the cache
> > was last updated (unless it is a modification that was made by this
> > client).
> 
> Clarification: the problem is IOW the fact that the server will not
> update mtime for any changes that are made within 1 second of one
> another. The same client will work fine with any server that has better
> resolution on mtime. Hence the suggestion:
> 
> > The only "solution" to your problem here is to upgrade the *server* to
> > Linux-2.6.x: the latter has 1 nanosecond resolution on the "mtime", and
> > so can register modifications that are far smaller than 1second.
> 

I don't think this is quite correct.  The 1 second or less gap is not 
between two modifications of the directory.  It is between the initial 
lookup and a remote modification.  The mtime IS being updated, it's 
just not being checked. ie.

time t: file foo is created on client2 (no lookup happens on client1),
        directory mtime = t
time t+10: file foo is accessed on client1, readdirplus, cache is 'as of' 
           time t+10
time t+10.5: file foo is replaced with different file on client2, 
         directory mtime = t + 10 (only full second granularity)
time t+10.75: file foo is accessed on client1, using stale handle.

So at time t+10.75, the mtime of foo has changed since initial access, and 
the mtime of the directory has changed.  Neither is checked because the 
readdirplus happened within a second.  The directory mtime is not even 
checked.  (I looked at tcpdump).

Try this one:

#
# create file remotely. (don't cause lookup on client1)
# sleep any number of seconds
# access file on client1 (cause lookup)
# replace file remotely
# access file on client1 (no lookup): stale file handle visible to
#    user space.  (rh9 retries this)
#

ssh -x client2 'rm foo; date >foo; ls -i foo; stat .'; \
sleep 3; \
cat foo; \
ssh -x client2 'touch foo.new; rm foo; mv foo.new foo; ls -i foo; stat .';\
cat foo; \
date


Looking at redhat 9 nfs (which doesn't have the same problem) it looks 
like it IS retrying the lookup when the cached file handle is stale.  This 
is a tcpdump of the last access that under FC1 generates the 'stale file 
handle' visible to userspace (sorry about the line wrap mangling)

10:20:09.359534 208.222.80.103.2205827529 > 208.222.80.60.2049: 120 
getattr fh Unknown/1 (DF)
10:20:09.360185 208.222.80.60.2049 > 208.222.80.103.2205827529: reply ok 
32 getattr ERROR: Stale NFS file handle (DF)
10:20:09.360202 208.222.80.103.800 > 208.222.80.60.nfs: . ack 733 win 
63712 <nop,nop,timestamp 100962223 300082326> (DF)
10:20:09.360505 208.222.80.103.2222604745 > 208.222.80.60.2049: 124 lookup 
fh Unknown/1 "foo" (DF)
10:20:09.361176 208.222.80.60.2049 > 208.222.80.103.2222604745: reply ok 
236 lookup fh Unknown/1 (DF)
10:20:09.396778 208.222.80.103.800 > 208.222.80.60.nfs: . ack 969 win 
63712 <nop,nop,timestamp 100962227 300082327> (DF)

You can see the access using a cached filehandle, the stale file handle 
reply, then a new lookup returning a new handle.

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/
