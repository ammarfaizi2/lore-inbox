Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263284AbVGAJAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbVGAJAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbVGAJAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:00:32 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:22026 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263284AbVGAJAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:00:15 -0400
Message-ID: <42C5061B.2090000@slaphack.com>
Date: Fri, 01 Jul 2005 04:00:11 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>	<e692861c05062522071fe380a5@mail.gmail.com>	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>	<42BF08CF.2020703@slaphack.com>	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>	<42BF2DC4.8030901@slaphack.com>	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>	<42BF667C.50606@slaphack.com>	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>	<42BF7167.80201@slaphack.com>	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>	<42C06D59.2090200@slaphack.com>	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>	<42C1B19F.6010808@slaphack.com> <87wtoedj77.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87wtoedj77.fsf@evinrude.uhoreg.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:
> On Tue, 28 Jun 2005 15:22:55 -0500, David Masover <ninja@slaphack.com> said:
> 
> 
>>Come to think of it, that changes the proposal a bit.  You need a
>>different way to access the meta-dir for files than for directories,
>>if we're going to support /meta/vfs.  No biggie:
> 
> 
>>/meta/vfs/file/home/bob/sue.mpg/acl
>>/meta/vfs/dir/home/bob/acl
> 
> 
> What if /home has an extended attribute named bob?  Then is
> /meta/vfs/dir/home/bob a file or a directory?

Ah, you caught it.  I knew it didn't feel right.  So /meta/vfs/file and 
/meta/vfs/dir are worthless.

Ok, there has to be a delimiter of some kind.  That, or there has to be 
a way we can pick up front how deep we're going.  Or, someone else has 
to come up with a better idea.  Or, start out with the assumption that 
we're talking about metadata, instead of the other way around.

I don't like delimiters because the way we usually deal with these is 
escaping them when we need to.  For instance, if I want to actually pass 
a literal " character to some command, I can wrap it in ' characters or 
add a \ to the front of it.

But we're expecting this to be simpler than that.  A program trying to 
access the metas for some file shouldn't have to worry about escaping.

Last time we tried to come up with a delimiter, we ended up with ... and 
..metas as possible candidates, and ..metas was in the source.  As 
unlikely as it is to hit either of those, I still don't like them.

Programs would mostly use the inodes anyway, and users would mostly use 
the /meta/vfs interface, but it's still not pretty.

But, the only alternative I can think of now is /meta/vfs/2/home/bob is 
a file and /meta/vfs/3/home/bob is a directory.  That's not something we 
want our users to have to do, especially considering we want to be able 
to have metadata of metadata.

That, or we can try something like:

/meta/vfs/#/home/#/bob	is a directory
/home/vfs/#/home/bob	is a file

where we add a delimiter to the /meta dir which identifies where each 
directory begins, not each set of metadata.  To clarify a bit:

$ ls /meta/vfs/
mime
permissions
acls
#
[snip]

$ ls /meta/vfs/#/
proc
sys
tmp
etc
home
[snip]

$ ls /meta/vfs/#/home
mime
permissions
acls
#
[snip]

$ ls /meta/vfs/#/home/#/
bob
billy
hank
sue
[snip]

This is pretty annoying for the user, though, because it's more verbose. 
  But, at least this way, we can guarentee that no one will kill our 
delimiter, because it exists in a new namespace we're creating anyway. 
That is, if we have to, the old xattrs stuff can go in its own folder, 
and so even if some app currently depends on a '#' app, it won't kill 
our delimiter.

Now, if only there was an easier delimiter to type...


Ok, since file-as-dir was going to do this anyway, I think the way to go 
is probably the original '...' delimiter.  It's safer, because it stays 
in /meta, but it's dangerous, because someone might actually try to 
create a '...' file on an existing system.  But, I think we can live 
with introducing a delimiter, more than we can live with uglifying the 
/meta/vfs interface, especially because "touch ..." wouldn't make the 
system blow up, you just couldn't easily get metadata for "..."
