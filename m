Received: by vger.rutgers.edu via listexpand id <168915-11364>; Fri, 16 Apr 1999 00:10:47 -0400
Received: by vger.rutgers.edu id <168726-11364>; Fri, 16 Apr 1999 00:07:17 -0400
Received: from [206.96.95.106] ([206.96.95.106]:10356 "EHLO fury.localdomain" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <160802-11366>; Fri, 16 Apr 1999 00:04:01 -0400
Date: Thu, 15 Apr 1999 21:18:13 -0700 (PDT)
From: Y2K <y2k@y2ker.com>
To: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: RFC on capability header in ELF
In-Reply-To: <3716A361.D0C5DCAB@ott.net>
Message-ID: <Pine.LNX.4.04.9904151948460.19667-100000@fury.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

This is how I interpret (and put spin on)
http://www1.us.kernel.org/pub/linux/libs/security/linux-privs/doc/linux-privs.html/
and the draft Posix documents I received from Casey Schaufler
<casey@sgi.com> who seems to have been highly involved in the process.
Notation used.
fP is file permitted
fI is file inherited
fE is file effective
pP is process permitted
pI is process inherited
pE is process effective
a tick mark after it means new capability set after exec.
ie pE' is new processes effective cap set.

First the standard rules upon exec:
1. pI'=pI
the process Inheritable set is passed unchanged through the exec()
2. pP' = fP | ( fI & pI  )
I would argue should be  pP' = fP | ( fI & pI & pP ) normally! The posix
drafts say it can be  pP' = (fP & x) | ( fI & pI ) where x is
implementation defined. I shall return to x later.
the process' permitted set becomes the combination of the permitted set of
the exec()'d file and those inheritable capabilities
of the exec()ing file that are also inheritable by the file.
I would argue that the inheritance should be further tempered by the
parent processes permissible cap set. 
3. pE' = fE & pP'
This is how the standard how I think that new sets should be calculated
after an exec if you have trusted information from either ext3 attributes,
or ELF headers in suitable marked executables. I will be chicken and not
enter the suid-root Vs. sticky-immutable war. Except a quick mention that
suid-root should store a uid and a failback mode indicator, so you can
on non-cap kernel choose to either EPERM, act like old suid-root, set euid
to ruid, set euid to stored elf uid.

The default for unheaded or unmarked binaries I believe should be as if it
was fI=-1, fP=0, fE=-1, x=0. 0 being none and -1 being all-- which reduces
the formulas to:
1. pI'=pI -- no surprise here
2.  pP' =  pI
which I would argue should be pP' = pI & pP
3. pE' =  pI 
Again I'd argue pE' = pI & pP

For headed elf binaries not specially marked I'd use the following
formulas setting x to 0:
1. pI' = pI
2.  pP' = ( fI & pI & pP )
3. 3. pE' = fE & pP'
This has the effect of ignoring fP which is far more dangerous than fI
ever was.
fI never raises any cap sets without filtering through other masks.
I do think that it is critical to mask it with the parents processes
permissible mask to make sure things stay better secured especially for
unmarked elf headers or my default situation.

I think non-marked elf header binaries as I have defined them are a fair
extension of the draft as section B.25.2.8 which allows extensions as long
as they are constraints and decrease capabilities.
Further more I believe that the spirit and intent of the posix drafts I
have read and the above web page reference indicate to me that it is the
intended behavior for capabilities inheritance control is mostly to fall
upon the parent process and not on the file attributes. 
In the case of apathy the standard also seems to assume the caps should
inherite.

Anyway comments welcome.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
