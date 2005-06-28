Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVF1UPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVF1UPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVF1UN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:13:59 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:6152 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261264AbVF1UIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:08:05 -0400
Message-ID: <42C1AE1E.6040401@slaphack.com>
Date: Tue, 28 Jun 2005 15:07:58 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hubert Chan <hubert@uhoreg.ca>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com> <42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca> <EBD8F590-0113-4509-9604-E6967C65C835@mac.com>
In-Reply-To: <EBD8F590-0113-4509-9604-E6967C65C835@mac.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:
> On Jun 27, 2005, at 22:21:35, Hubert Chan wrote:
> 
>> On Mon, 27 Jun 2005 18:27:26 -0500, David Masover 
>> <ninja@slaphack.com> said:
>>
>>> Kyle Moffett wrote:
>>>
>>>> I think the '...' is just a bad idea in general, because it breaks
>>>> tar and such.  An interface like this might be simpler to design and
>>>> use:
>>>>
>>>> # mkdir /attr
>>>> # mount -t attrfs attrfs /attr
>>>>
>>>> /attr/fd/$FD_NUM == '...' directory for a filedescriptor
>>>> /attr/fs/$DEV_NUM/$INODE_NUM == '...' directory for an inode
>>
>>
>> The most obvious (at least obvious for me) complaint about this is  that
>> the attributes are separate from the file.  (In other words, it's a  bit
>> ugly. ;-) ) So if you want to backup a file, along with all its
>> (extended) attributes (or substreams, or ... etc. ...), you need to
>> backup the file, and find the appropriate /attr/fs/$DEV_NUM/$INODE_NUM
>> and back that up.  If I want to edit an attribute, I need to find
>> $DEV_NUM and $INODE_NUM (which I have no idea how to do), rather than
>> just "edit foo/.../extended_attribute".  (Or using your "getattrpath"
>> command, it would be a two-step process -- run getattrpath, then run
>> editor -- rather than a one-step process.  Of course, this is only
>> mildly annoying.)
> 
> 
> These are not really "attributes" so much as they are "metadata", for
> example, a "contents" subdirectory, if one existed, would be based on
> the original file, and therefore non-unique, but would be looked up
> based on information about the original file.

If you say so.  I like the name "meta" because it looks cooler and is
easier to type, but I could live with "attr".

>> It also exposes a difference between attributes and regular files.
>> e.g. can I add attributes to an attribute?  (say, I have a thumbnail
>> attribute for the file ~/foo, and I want to add a mime-type  attribute to
>> that thumbnail attribute.)  If you want to allow it, you have to be
>> careful not to run into a big loop generating an infinite number of
>> inodes in the attrfs. (e.g.
>> /attr/fs/$(getattrpath /attr/fs/$(getattrpath ~/foo)/thumbnail)/ mimetype
>> -- attrfs shouldn't generate the inode for that until
>> /attr/fs/$(getattrpath~/foo)/thumbnail is accessed, and maybe not even
>> then...)
> 
> 
> Agreed.  I discuss this more below
> 
>> That said, I prefer that interface over xattr or openat.
> 
> 
> Absolutely.  On the other hand, that's not to say it can't be improved.
> 
>>
>>>> It would be usable from a shell with a simple "getattrpath" command
>>>> which returns "fs/$DEV_NUM/$INODE_NUM" by stat-ing any given path.
>>
>>
>>> Still pretty annoying, but maybe a good idea, especially if the shell
>>> gets extended to support it.  Not sure I like using inode numbers,
>>> though -- I like the idea of being able to symlink to stuff inside  the
>>> meta-file dir.
>>>
>>
>> The advantage of using inodes rather than pathnames is that it is  robust
>> with respect to file renaming/moving.  It also allows things like
>> adding attributes to symlinks (since the inode number for a symlink is
>> different from the inode number for the file that it points to).
>>
>> You can still symlink.  It just takes a little more effort to  figure out
>> what $DEV_NUM/$INODE_NUM to use.
> 
> 
> Also, unlike a symlink, if the path doesn't change and the file does, it
> will break, also, if the file is removed and another created  elsewhere, it
> will be redirected improperly.  Perhaps a new symlink syntax is  needed to
> allow attribute specification (Ick, more changes :-\).

There are symlinks, and there are hardlinks.  When I want a link to a
file which doesn't change even if the file is moved, I use a hardlink.
When I want a link to a particular location, even if the file there is
deleted and then replaced, or if the file is not likely to move anytime
soon, I use a symlink.

Besides, can't we have it automagically figure out what the fs is once
we give it the device number?

I propose we should be able to have:

	/meta/$DEV_NUM/$INODE_NUM
	/meta/vfs/path/to/file

That way, I can symlink to whichever is appropriate.

>>> Hans, thoughts?  Seems to be namespace fragmentation, but seems
>>> usable, less breakage, and so on.  And should it be /attr or /meta?
>>
>>
>> For the mount point, it doesn't matter; it's up to the user.  It's the
>> attrfs or metafs or ???fs that matters (but which will greatly  influence
>> whether people user /attr or /meta).
> 
> 
> "meta" seems the more descriptive name.  There should also probably be a
> somewhat standardized location for this, such that programs can  locate it
> without much trouble.  This mechanism would be usable from all FSs, and
> could be built into the VFS.

Maybe.  I think it should be its own FS, mountable and unmountable, just
like /proc or /sys.  It's a standardized location anyway, but easier to
admin that way.

But we definitely want to support multiple FSes.  Even more reason to
make it a separate system, accessible as its own mountable FS.

> Also, it would allow one to access the  meta
> data of meta data (if supported by the filesystem, and possibly only
> through the file descriptor lookup, due to numbering limitations.)

Or just use:

/meta/vfs/meta/$DEV_NUM/$INODE_NUM
/meta/vfs/meta/vfs/path/to/file/some/meta/file

Loop as many times as the FS supports -- if the FS doesn't like a
particular amount of looping, the file will simply not be there.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsGuHngHNmZLgCUhAQLFDA//etF3JuQVLCz4XV60yDWZ3rEtf9mHew7F
Ki0ON1q2P94TppOhjhUWPUQ8v53K5AIRkXyr0Uc1AVxqzj8ff5IHxYRXOJqB1OAC
3sJpRawIW+4g7Odwej8320gVrSPGJ4xMOm5HN2QFWhjlqPdAcMIydoZnM5WFAV/N
0/iaHA54wIrxGepCp0KPmyW3PJTRQj3PiBInvEER6dSnPpjKScEbSGLgVXHaHVpA
X3ujOvNjFzmPrbmytQuJY3lB3dFSOXVarv0RKOaCqbDUW1KoWLiXnXD1t+9qLqRy
w3LlRFMTooh5jsmWsorEVDqIS2ZsPL5fnYOkx5pTgUU2/pVLyedJWnB3zbzOqZ4T
kypdr9yZZqoVakYNTmHqEGQp4z5BuKzZgoAjAJXJrST1+IhdDfjAWQ61NrSsFP3C
XIVfsuY2WwUiy3wUrATUgIL8cpeKz9WRzJOsnD7b5e8YB8ceR8uElSD2VB5RKF+q
v7E1chqofOWgIgclSPMq74jCa3iD6PF5W8ohS5J0P4TafyTr8KGB17Is81O55d5D
3aoioC6JzKW9iQ4SM+CxeS5gTNqI/O9cA/NU+aZzrz9P6xQSB5bOoMMfm1N3pzLD
obhZaGyVZtpn5mc+AoVi9JLKs105JFZzHgdZYiwsJdIR07oMZYfOU34As0dgp78+
O6Em4T/9YAQ=
=hvkI
-----END PGP SIGNATURE-----
