Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277704AbRJNU6e>; Sun, 14 Oct 2001 16:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277608AbRJNU6Z>; Sun, 14 Oct 2001 16:58:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48196 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277603AbRJNU6U>; Sun, 14 Oct 2001 16:58:20 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: [RFC] "Text file busy" when overwriting libraries
In-Reply-To: <E15sk4C-0007Be-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2001 14:48:06 -0600
In-Reply-To: <E15sk4C-0007Be-00@the-village.bc.nu>
Message-ID: <m13d4mq77d.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > My big question is how to correctly define O_EXEC for every
> > architecture.  But I would like to know if there are objectionable
> > parts as well.
> 
> It looks totally unworkable. Open() has side effects on a large number of
> platforms, and being able to open an exec only file might trigger them
> as well as all sorts of other potential problems where files are
> marked rwx by accident as is very common.

We already can open an exec only file just open("file", 0).
In fact it looks like you can open a file with no permissions at all.
You just can't do anything with it.

All O_EXEC does is stipulate that you must have the exec permission
to the file, and it does cause a side effect.  Possibly it should
be broken into open, and then side effect. fcntl(fd,F_DENYWRITE).

My primary observation is that we don't need to manage the DENYWRITE
at the mmap level.  The file descriptor level gets the job done with
less code, fewer suprises, fewer races.
 
> You narrow the DoS vulnerability and add a whole new set of open based
> ones.

You may be write.  With the cleanup of the implementation by moving
everything into open (where we implement this for exec), it hadn't
occured to me that I might be opening a different kettle of fish.
 
> This isnt a problem worth solving. Shared libraries are managed by the
> superuser. The shared library tools already do the right thing. The
> superuser can equally reboot the machine or reformat the disk by accident
> anyway.

Yes the superuser can shoot himself in the foot, and by that argument
I should delete the entire implementation of MAP_DENYWRITE from the
kernel.  

It is by no means true that the existing user space tools get it
right.  I have multiple shared libraries where the owner has write
permission to them.  And I do believe gcc -o foo.so does not do a
unlink/open(O_CREAT) pair.  Nor does cp.

As for the superuser being the only one who touches shared libaries.
That is as true as it is that the superuser is the only one who
touches binaries, or scripts.

It is also quite unobvious that you shouldn't write to shared
libraries.  If you have looked at how shared libaries are mapped and
you know that they are mapped into memory with mmap(MAP_PRIVATE), and
you understand how mmap works.  It is quite obvious why you shouldn't
touch them.  There are a lot of users that haven't done that however.

Accidental rwx permissions settings may indeed be a valid argument,
though I think that is more a bug in chmod, than anything else.

Eric
