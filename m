Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSFMBa3>; Wed, 12 Jun 2002 21:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFMBa3>; Wed, 12 Jun 2002 21:30:29 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:61652
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S317391AbSFMBa0>; Wed, 12 Jun 2002 21:30:26 -0400
Date: Wed, 12 Jun 2002 18:30:17 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <200206120030.g5C0UDF139852@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.43.0206121735350.17355-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Albert D. Cahalan wrote:

> Francois Gouget writes:
>
> > This looks like a bad idea. The reason is that the VFAT driver is the
> > wrong abstraction layer to support the '.lnk' files:
> >
> >  * on Windows if you open("foo.lnk") you get the .lnk file, not the file
> > it 'links' to. On Linux you would get the file it points to instead
> > which is a different behavior.
>
> That's a common Windows app bug which exists exactly because
> the Microsoft implementation is at the wrong abstraction layer.

No it is not a 'Windows app bug' bug. It is you who are mistaken because
you persist in believing that .lnk files are or are meant to be symbolic
links. They are not.

Unix has the exact equivalent to .lnk files. These are the '.dsektop'
files used by KDE and Gnome (they even used to be called '.kdelnk' files
in KDE 1).
Look at all the similarities:
 * both may contain a path to another file
 * both may contain a command to be executed when clicked upon
 * for both, the above command may include command line options and that
can even take a filename as a parameter (e.g. for drag and drop)
 * both let you specify the directory the above command is to be
executed into
 * both usually contain a reference to an icon
 * both are used by the 'desktop' layer to implement the desktop menus
(Start Menu, KDE Start, Gnome foot menu) and icons

The differences are very minor:
 * '.lnk' files can reference objects that do not exist in the
filesystem. This seems to be a relatively recent addition and I am not
sure that '.desktop' files have a similar concept
 * the format of '.lnk' files is binary while the '.desktop' files are
text files
 * the '.desktop' files are also used to handle MIME type associations
by KDE but not Gnome (uses '.mime' and '.keys' files) and not Windows
(uses the registry)

See below for more information about '.desktop' files:
http://webcvs.kde.org/cgi-bin/cvsweb.cgi/~checkout~/kdelibs/kio/DESKTOP_ENTRY_STANDARD?rev=1.9

So as you see '.lnk' are the exact equivalent of '.desktop' files on
Unix.
 * Thus, saying that not dereferencing '.lnk' files is a 'common Windows
app bug' is equivalent to saying that gcc is buggy because it does not
dereference '.desktop' files.
 * Saying that it is because 'because the Microsoft implementation is at
the wrong abstraction layer' is equivalent to saying that '.desktop'
files are at the wrong abstraction layer and should have been
implemented as symbolic links.
 * And converting between '.lnk' files and symbolic links in the VFAT
driver is equivalent to converting between '.desktop' files and symbolic
links in the ext2 driver.

Let's face it, Windows simply does not have anything like symbolic
links. Now you can highjack the concept of '.lnk' files to compensate
for that, but this is going to be a kludge of your doing. So don't
complain about Microsoft doing '.lnk' files wrong.



Now, assuming that it does get implemented.

 * Is there going to be *any* '.lnk' files created by Windows that are
going to be correctly converted to symbolic links? As far as I can tell
there are types of '.lnk' files:
   - absolute path 'x:\...'
     -> not supported because of the drive conversion issue
   - UNC paths of the form '\\host\share\...'
     -> not supported if host != localhost
     -> if local they will be of the form '\\localhost\X\...' where X is
a drive letter. So they will not be supported either (or am I wrong
here?)
   - commands with parameters
     -> not supported. Plus the command probably contains a drive letter
and would not be executable without Wine anyway
   - references to objects not in the filesystem (e.g. 'My Computer')
     -> not supported
   - relative paths
     -> as far as I know Windows does not create any such '.lnk' file.
If I am wrong. how does one create such a .lnk file?

 * Is this going to be the default or just an option? Given that this
seems only useful in corner cases and has the potential to cause a lot
of trouble, I sure hope it is not going to be the default. You yourself
would oppose a similar option if it were the default on the ext2
filesystem.

 * Still assuming that this gets implemented, I would also like that
plans are made to make it possible for Wine to get access to the content
of these files. So what would be the API for doing so?



[...]
> This is the TOTAL CRAP option. Clearly you've never used LD_PRELOAD.
> You're not going to get that working with static linked executables,
> setuid, setgid, very old executables, very new executables, stuff
> written in FreePascal, etc., etc., etc.

I know all the problems caused by LD_PRELOAD. xalf, aRts and ESounD all
use it for various purposes and they all cause problems. However, there
are so few situations where what you propose seems useful that it might
just be enough to take care of the issue. But I will grant you that it
is definitely not a general purpose solution.


Besides buying a larger disk (include the obligatory 'pretty cheap these
days'), repartitionning, loopback filesystems which I agree all have
their drawbacks, wouldn't the best solution (given the above) be to use
UMSDOS?
It seems to me that UMSDOS does a much better job at making a VFAT
partition usable as a Unix filesystem:

 * supports symbolic links of course
 * also supports hard links
 * supports ownership and permissions which if you are going to
regularly use it would be a good thing to have
 * supports socket files (for AF_LOCAL servers, useful if your
WinePrefix points to that partition for instance)
 * even supports device files

They even mention the exact scenario you are facing:
http://www.tldp.org/HOWTO/UMSDOS-HOWTO-8.html

And if there is any issue with UMSDOS, then I think it would be more
useful to fix these issues than to hack .lnk files.


> > This looks like it could be the next 'unhide' thing. See:
>
> That was botched.
>
> 1. no backdoor
> 2. no Wine patch to use the backdoor

2. is redundant as it follows from 1. Obviously not Wine's fault.



--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
 Advice is what we ask for when we already know the answer but wish we didn't
                                 -- Eric Jong

