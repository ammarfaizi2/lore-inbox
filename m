Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVBBVNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVBBVNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVBBUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:08:52 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:19883 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262685AbVBBTvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:51:39 -0500
Date: Wed, 02 Feb 2005 14:45:43 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <1107369381.5992.73.camel@localhost>
To: Ram <linuxram@us.ibm.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <42012DE7.4080003@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <20050116160213.GB13624@fieldses.org>
 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050116184209.GD13624@fieldses.org>
 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
 <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
 <20050201232106.GA22118@fieldses.org> <1107369381.5992.73.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ram wrote:
> On Tue, 2005-02-01 at 15:21, J. Bruce Fields wrote:
> 
>>On Tue, Jan 25, 2005 at 01:07:12PM -0800, Ram wrote:
>>
>>>If there exists a private subtree in a larger shared subtree, what
>>>happens when the larger shared subtree is rbound to some other place? 
>>>Is a new private subtree created in the new larger shared subtree? or
>>>will that be pruned out in the new larger subtree?
>>
>>"mount --rbind" will always do at least all the mounts that it did
>>before the introduction of shared subtrees--so certainly it will copy
>>private subtrees along with shared ones.  (Since subtrees are private by
>>default, anything else would make --rbind do nothing by default.) My
>>understanding of Viro's RFC is that the new subtree will have no
>>connection with the preexisting private subtree (we want private
>>subtrees to stay private), but that the new copy will end up with
>>whatever propagation the target of the "mount --rbind" had.  (So the
>>addition of the copy of the private subtree to the target vfsmount will
>>be replicated on any vfsmount that the target vfsmount propogates to,
>>and those copies will propagate among themselves in the same way that
>>the copies of the target vfsmount propagate to each other.)
> 
> 
> ok. that makes sense. As you said the private subtree shall get copied
> to the new location, however propogations wont be set in either
> directions. However I have a rather unusual requirement which forces 
> multiple rbind of a shared subtree within the same shared subtree.
> 
> I did the calculation and found that the tree simply explodes with
> vfsstructs.  If I mark a subtree within the larger shared tree as
> private, then the number of vfsstructs grows linearly O(n). However if
> there was a way of marking a subtree within the larger shared tree as
> unclonable than the increase in number of vfsstruct is constant.
> 
> What I am essentially driving at is, can we add another feature which 
> allows me to mark a subtree as unclonable?
> 
> 
> Read below to see how the tree explodes:
> 
> to run you through an example: 
> 
> (In case the tree pictures below gets garbled, it can also be seen at 
>  http://www.sudhaa.com/~ram/readahead/sharedsubtree/subtree )
> 
> step 1:
>    lets say the root tree has just two directories with one vfsstruct. 
>                     root
>                    /    \
>                   tmp    usr
>     All I want is to be able to see the entire root tree 
>    (but not anything under /root/tmp) to be viewable under /root/tmp/m* 
> 
> step2:
>       mount --make-shared /root
> 
>       mkdir -p /tmp/m1
> 
>       mount --rbind /root /tmp/m1
> 
>       the new tree now looks like this:
> 
>                     root
>                    /    \
>                  tmp    usr
>                 /
>                m1
>               /  \ 
>              tmp  usr
>              /
>             m1
> 
>           it has two vfsstructs
> 
> step3: 
>             mkdir -p /tmp/m2
>             mount --rbind /root /tmp/m2

At this step, you probably shouldn't be using --rbind, but --bind
instead to only bind a copy of the root vfsmount, so it now looks like:

>                       root
>                      /    \ 
>                    tmp     usr
>                   /    \
>                 m1       m2
>                / \       /  \
>              tmp  usr   tmp  usr
>              / \         / \ 
>             m1  m2      m1  m2

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCAS3ndQs4kOxk3/MRAm/qAJ0awCE49/g+HhMdX0MBZnFLSp2IjACgj5EQ
El+YLq25hQeDAt9Y92nqoAU=
=so+d
-----END PGP SIGNATURE-----
