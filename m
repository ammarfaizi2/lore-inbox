Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUAIUJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAIUJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:09:09 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:62635 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264147AbUAIUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:07:10 -0500
Date: Fri, 09 Jan 2004 15:06:49 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
To: Ian Kent <raven@themaw.net>
Cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFF09D9.40909@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig81B952048166ED41571B2513;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81B952048166ED41571B2513
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:

>On Thu, 8 Jan 2004, Mike Waychison wrote:
>
>  
>
>>The direct map 'triggers' will be taken care of by another filesystem
>>with a magic root directory that will catch traversals using some
>>follow_link magic.   I wrote a prototype for this last summer, but
>>haven't released it as the userspace stuff completely does not fit in
>>with the existing daemon that was out at the time do the the mess of
>>glue that was pgids, pipes and processes.   It worked in the simple
>>case, but it didn't extend to being able to direct mount an indirect
>>map, nor was it able to do the lazy mounting in multimounts as I had
>>desired.
>>    
>>
>
>Is this the stuf that Al Viro is working on?
>
>  
>
Al is proposing doing the same thing directly in the VFS instead of 
using a magic filesystem as I've described in the document.  

> Indeed, I
>haven't solved my requirement of a transparent autofs filesystem aka.
>Solaris automounter again. A difficult problem that will require
>considerable effort.
>
>  
>
What do you mean by this?  Something that doesn't show up in 
/proc/mounts?  I don't see this as much of an issue..  On any decently 
large machine, there are so many entries anyway that /etc/mtab and 
/proc/mounts become humanly unparseable anyhow.

>>>>This is the subtle difference between direct and indirect maps.   The
>>>>direct map keys are absolute paths, not path components.  We are
>>>>implementing direct mounts as individual filesystems that will trap on
>>>>traversal into their base directory.  This filesystem has no idea where
>>>>it is located as far as the user is concerned.  We need to tell the
>>>>filesystem directly so that the usermode helper can look it up.
>>>>Conversely, the indirect map uses the sub-directory name as a mapkey.
>>>>
>>>>
>>>>        
>>>>
>>>I'm not sure what you are saying here. Does this mean there is a mount for
>>>every direct mount (this might be what you call a trigger)?
>>>
>>>
>>>
>>>      
>>>
>>Yes, it is its own filesystem (type autofs).  This is needed because we
>>need to overlay direct triggers within NFS filesystems for multimounts.
>>    
>>
>
>Ahh. I see, you are talking about the cross filesystem problem. I haven't
>solved that in what I have done either. Fortuneately I still get a good
>hit rate in satisfying peoples' needs as in practice many people don't use
>full automounter functionality.
>
>  
>
Yup.  But still, one of the nice things about a full automounter 
solution is accessing a netapp with hundreds of exports through /net in 
a reasonably fast way.

>>??  Really?  I find that hard to believe.  I thought Solaris shared it's
>>automounter with HPUX and AIX.  I may be wrong though.
>>    
>>
>
>Old versions perhaps. AIX 4.x was the last I used. It was definately like
>that then. 500+ automounts tends to cluter the mount display a bit.
>
>  
>
Could be.  Either way, on a system with a thousand NFS shares 
automounted, I'm not really concerned about what the mounttable looks 
like.  It won't be human parseable anyway.

>>>Mmm. The vfsmount_lock is available to modules in 2.6. At least it was in
>>>test11. I'm sure I compiled the module under 2.6 as well???
>>>
>>>I thought that, taking the dcache_lock was the correct thing to do when
>>>traversing a dentry list?
>>>
>>>
>>>
>>>      
>>>
>>Walking dentrys still takes the dcache_lock, however walking vfsmounts
>>takes the vfsmount_lock.  dcache_lock is no longer used for fast path
>>walking either (to the best of my understanding).
>>
>>find . -name '*.[ch]' -not -path '*SCCS*' | xargs grep vfsmount_lock |
>>grep EXPORT
>>    
>>
>
>Strange. How does the module compile I wonder? How does it load without
>unresolved symbols? Another little mystery to work on.
>
>  
>
No, you're module doesn't use vfsmount_lock.  At least the module in 
autofs4-2.4-module-20031201.tar.gz doesn't.

>>The raciness comes from the fact that we now support the lazy-mounting
>>of multimount offsets using embedded direct mounts.  Autofs4 mounts all
>>(or as much as it can) from the multimount all together, and unmounts it
>>all on expiry.
>>    
>>
>
>But 4.1 does lazy mount for several maps. Mounts that are triggered
>during the umount step of the expire are put on a wait queue along with
>the task requesting the umount. I think autofs always worked that way.
>
>  
>
This isn't lazy mounting per se.  If you are talking about autofs4's use 
of AUTOFS_INF_EXPIRING, it's there to prevent somebody from walking into 
a multimount while it is expiring. 

>>>Hang on. From the discussion my impression of a lazy mount is that it is
>>>not actually mounted!
>>>
>>>
>>>
>>>      
>>>
>>Lazy _un_mounts as opposed to lazy mounts. Lazy unmounts are described
>>in umount(8):
>>    
>>
>
>But will this leave the filesystem in a consistent state and allow further
>mount activity on that mount point?
>  
>
The underlying autofs filesystem?  Sure.


-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enig81B952048166ED41571B2513
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//wncdQs4kOxk3/MRAkbfAJ9NB/gNAMmLZIcTt75hQkgpgZkg3QCfTIoJ
JQ33wzhmHrWB7O4OoFbxWCY=
=GQ1k
-----END PGP SIGNATURE-----

--------------enig81B952048166ED41571B2513--

