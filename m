Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVDQRqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDQRqC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 13:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVDQRqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 13:46:02 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:37829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261373AbVDQRpt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 13:45:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lk2c5oZ23Je7w7ln+qAUOo1C8yDTDo5caWjh120xqWymNn0Mp1YR/pvrpHAta3GqovwRXpfwnFltuojehyEeqF6ec9RBlAy8PD6115EcBSi0OavdyygEQ2Lu3M/JvTyBrGyVEEAB+TDFSKDtHnpa0s2MLuB1xA9jA5TkWcAnj08=
Message-ID: <a4e6962a05041710451d74f037@mail.gmail.com>
Date: Sun, 17 Apr 2005 12:45:48 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: jamie@shareable.org, dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050331200502.GA24589@infradead.org>
	 <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
	 <20050411153619.GA25987@nevyn.them.org>
	 <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
	 <20050411181717.GA1129@nevyn.them.org>
	 <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
	 <20050411192223.GA3707@nevyn.them.org>
	 <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
	 <20050411214123.GF32535@mail.shareable.org>
	 <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > I think that would be _much_ nicer implemented as a mount which is
> > invisible to other users, rather than one which causes the admin's
> > scripts to spew error messages.
>> 
> > Is the namespace mechanism at all suitable for that?
> 
> It is certainly the right tool for this.  However currently private
> namespaces are quite limited.  The only sane usage I can think of is
> that before mounting the user starts a shell with CLONE_NS, and does
> the mount in this.  However all the other programs he already has
> running (editor, browser, desktop environment) won't be able to access
> the mount.
> 

I'd like to second that I think private-namespaces are the right way
to solve this sort of problem.  It also helps not cluttering the
global namespace with user-local mounts

>
> Shared subtrees and more support in userspace tools is needed before
> private namespaces can become really useful.
> 

I'd like to talk about this a bit more and start driving to a solution
here.  I've been looking at the namespace code quite a bit and was
just about to dive in and start checking into adding/fixing certain
aspects such as stackable namespaces, optional inheritence (changes in
a parent namespace are reflected in the child but not vice-versa),
etc.

One aspect I was thinking about here was a mount flag that would give
you a new private namespace (if you didn't already have one) for the
mount (and I guess that would impact any subsequent mounts from the
user in that shell).  Another option would be a 'newns' style
system-call, but I'm generally against adding new system calls.

Shared subtrees are a tricky one.  I know how we would handle it in
V9FS, but not sure how well that would translate to others
(essentially we'd re-export the subtree so other user's could mount it
individually -- but that's a very Plan 9 solution and may not be what
more UNIX-minded folks would want -- we also need to improve our own
server infrastructure to more efficiently support such a re-export).

So, to sum up I think private namespaces is the right solution, and
I'd rather put effort into making it more useful than work-around the
fact that its not practical right now.

       -eric
