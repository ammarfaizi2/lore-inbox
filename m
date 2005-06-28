Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVF1Ejh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVF1Ejh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVF1Ejg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:39:36 -0400
Received: from smtpout.mac.com ([17.250.248.46]:57059 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262508AbVF1Eja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:39:30 -0400
In-Reply-To: <87mzpbrvpf.fsf@evinrude.uhoreg.ca>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com> <42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca> <EBD8F590-0113-4509-9604-E6967C65C835@mac.com> <87mzpbrvpf.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>
Cc: David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 00:38:38 -0400
To: Hubert Chan <hubert@uhoreg.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27, 2005, at 23:45:00, Hubert Chan wrote:
> On Mon, 27 Jun 2005 22:59:24 -0400, Kyle Moffett  
> <mrmacman_g4@mac.com> said:
>> /attr/fd/$FD_NUM == '...' directory for a filedescriptor
>> /attr/fs/$DEV_NUM/$INODE_NUM == '...' directory for an inode
>
> [...]
>
>> These are not really "attributes" so much as they are "metadata", for
>> example, a "contents" subdirectory, if one existed, would be based on
>> the original file, and therefore non-unique, but would be looked up
>> based on information about the original file.
>
> I think for most people on the reiser-fs list, the '...' directory
> represents an interface to many things including
> - automatic aggregating/tar/untar/compress
> - a different interface to stat data
> - adding extended attributes/substreams/acls/etc.
> - anything else you might imagine
> (I think this is your understanding too?  Just double-checking.)
> So some of that stuff would be separate from the file.  (Separate  
> in the
> sense that it's not generated from the file's binary data.)

Ok.  Those things should probably be divided up.  Stuff like POSIX
extended attributes and such that have existing interfaces should use
those.  Other types of data should chose other interfaces that make
the most sense for that type of data.  I think that the /meta fs
should probably only be used when the data is generated from the
existing file or directory, and perhaps a few other cases.

> Personally, I don't like it all being in one directory, but it's not
> that important.

I agree with the first, but I think that the implementation and usage
confusion will be one of the barriers preventing '...' or metafs merge.

>> Also, unlike a symlink, if the path doesn't change and the file does,
>> it will break, also, if the file is removed and another created
>> elsewhere, it will be redirected improperly.  Perhaps a new symlink
>> syntax is needed to allow attribute specification (Ick, more changes
>> :-\).
>
> I think those breakages are acceptable.  (IMHO) In other words, I  
> think
> it would not occur very often without the user being aware of it, and
> should very rarely result in catastrophic effects.

Agreed.  On the other hand, perhaps filesystems that support such meta
data should internally assign the appropriate numbering to make it work
nicely.

> One other minor annoyance is it isn't easy to go backwards from the
> ... directory to the file.  e.g. if I have a symlink that points to
> /attr/fs/2/92036, I don't know what file's attributes that refers to.
> Hopefully I'm sane enough to give the symlink a descriptive enough
> name...

I don't see this occurring often enough to be a major problem, and in
any case inodes are not path-exclusive (think hardlinks).  If they have
the filedescriptor open, however, they could use /proc/$PID/* to figure
out where the file is.

>> "meta" seems the more descriptive name.  There should also  
>> probably be
>> a somewhat standardized location for this, such that programs can
>> locate it without much trouble.
>
> Agreed.  Ultimately, it's the user's decision where to put it, but
> probably 99.99999% of all people will put it in the same place.  Just
> like you could put procfs or sysfs somewhere other than /proc or / 
> sys if
> you really wanted to, but nobody does that.

Yeah.  I was referring more to calling it "metafs" than "attrfs",
because it seems it would be more than just attributes.

> One other issue is that the attrfs/metafs needs to communicate with  
> the
> other filesystem somehow.  It needs to know if the filesystem can  
> handle
> storing of extended attributes/substreams/etc. so that it knows  
> whether
> or not to allow those interfaces.

Those would be tied to file descriptor (/meta/fd) or filesystem device
ID (/meta/fs/$DEV), and would therefore be accessible from metafs in a
similar way to how filedescriptor path info is available from procfs.

> In my
> /attr/fs/$(getattrpath /attr/fs/$(getattrpath ~/foo)/thumbnail)/ 
> mimetype
> example, it needs to be smart enough to store that in ~/foo's
> filesystem.  etc.

Agreed.  On another note, it's nice to see the flamewar has died out
and several technical discussions are taking place on various  
levels :-D.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

