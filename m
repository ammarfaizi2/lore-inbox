Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTEBAAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbTEBAAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:00:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbTEBAAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:00:01 -0400
Date: Thu, 1 May 2003 17:09:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mlmoser@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
Message-Id: <20030501170958.3f130646.rddunlap@osdl.org>
In-Reply-To: <20030430172102.69e13ce9.rddunlap@osdl.org>
References: <200304301946130000.01139CC8@smtp.comcast.net>
	<20030430172102.69e13ce9.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__1_May_2003_17:09:58_-0700_09469b20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__1_May_2003_17:09:58_-0700_09469b20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2003 17:21:02 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| Hi,
| 
| I'm probably misreading this...but,
| 
| Have you tried this yet?  Does it modify/customize all Kconfig
| and Makefiles for the selected tree splits?
| 
| A few days ago, in one tree, I rm-ed arch/{all that I don't need}
| and drivers/{all that I don't need}.
| After that I couldn't run "make *config" because it wants all of
| those files, even if I don't want them.
| 
| So there are many edits that needed to be done in lots of
| Kconfig and Makefiles if one selectively pulls or omits certain
| sub-directories.

and on 2003-04-30 rddunlap wrote:
| I seem to try for simple solutions when possible and feasible.
| 
| In this case, if I were doing it, I would try changing (e.g.) in
| arch/i386/kernel/Kconfig, this line:
| source "drivers/eisa/Kconfig"
| to
| optsource "drivers/eisa/Kconfig"
| where optsource means that the file is optional -- if not found,
| ignore it.  And then see what happens, how far it can go,
| what the next problem is....
| 
| If this could be made to work, then entire subdirectories/subsystems
| could be optional.

So I did a proof-of-concept version of this, without modifying any
source code.  I rm-ed arch/<many>, drivers/<many>, and fs/<many>
and then wrote a shell script that looks for missing dirs, Kconfigs,
and Makefile.lib files and puts empty ones back in their places.
The shell script only works for what I rm-ed, but it could be made
smarter if anyone wants to pursue this.  (attached)

After doing that I was able to build and boot that kernel, so it
(concept) did work.

For a kernel source tree that hadn't been built/compiled in, the size
was reduced from roughly 200 MB down to roughly 133 MB.

~Randy


| On Wed, 30 Apr 2003 19:46:13 -0400 rmoser <mlmoser@comcast.net> wrote:
| 
| | Eh, Linus won't be happy making a bunch of tarballs.
| | I've made it less work if you read the message here...
| | 
| | The message mirrored at:
| | 
| | http://marc.theaimsgroup.com/?l=linux-kernel&m=105173077417526&w=2
| | 
| | Shows my pre-thought on this subject.  I thought a bit more,
| | and began to come up with a simple sketch to lead the
| | way in case anyone becomes interested.
| | 
| | First off, the kernel tarballs would be built by a script
| | that splits the source tree apart appropriately and tar's it
| | up.  How this is done is explained.
| | 
| | Second off, there's always a script to download that runs
| | wget and gets the source tree from which it was downloaded.
| | The whole thing.  As in, every tarball is downloaded and
| | untar'd for the user, assembling the full kernel source
| | tree (as it would be if you untar'd it now).
| | 
| | Now, I explained LOD's in that message above in small
| | detail.  But, for clarity, LOD's are files which explain
| | which pieces of source in the kernel tree belong to the
| | LOD; what gets added to the config; where their makefiles
| | are; what config options depend on other linux options;
| | and what groups these LOD's are in.
| | 
| | A command such as `make disttree` should read the LOD's,
| | split apart each linux option, tar 'em together, and
| | then compress the tar's.  Then Linus could just scp the
| | new directory of tar's and a script up.
| | 
| | As for download, the script that goes up can be
| | downloaded (duh), and then run (... why do I bother?).
| | Now this script would run in "dumb mode" (unless the
| | user tells it not to maybe?) and rip down the whole
| | tree, untar it, and rebuild the original source tree.
| | I think.  I'm not sure, I really haven't tried yet.
| | I'll tell you how it works after it's implimented, if
| | ever that happens.  This would likely require wget.
| | 
| | Of course there's always the ftp method.  Go download
| | the pieces you want, untar 'em, copy 'em to the same
| | directory, and the build system adjusts.  but newbies
| | and developers, for completely opposite reasons, will
| | want to use the script in dumb mode.
| | 
| | For experienced users, this will make configuration
| | somewhat easier, as the user can avoid being prompted
| | for irrelavent drivers.  This is just a concept idea,
| | not a fully thought-out idea.  What do you think?
| | 
| | --Bluefox Icy

--Multipart_Thu__1_May_2003_17:09:58_-0700_09469b20
Content-Type: application/octet-stream;
 name="builder"
Content-Disposition: attachment;
 filename="builder"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojIGlkZWEgYW5kIHNjcmlwdCBieSBSYW5keS5EdW5sYXAgPHJkZHVubGFwQG9z
ZGwub3JnPgoKIyBvcHRzb3VyY2UgdGVzdDogIGFueSBLY29uZmlnICJzb3VyY2UgPGZpbGVuYW1l
PiIgZmlsZXMgdGhhdCBhcmUgbWlzc2luZwojCWFyZSB0b3VjaGVkIHRvIHByb2R1Y2UvcHJvdmlk
ZSBlbXB0eSBmaWxlcyBmb3IgdGhlbTsKIyBtYWtlIGNsZWFuIC0tLT4gbWFrZSAtayBjbGVhbgoj
ICAgdG8gaWdub3JlIG1pc3NpbmcgTWFrZWZpbGVzCgpESVJTPSJkcml2ZXJzL2Vpc2EgZHJpdmVy
cy9tY2EgZHJpdmVycy9tdGQgZHJpdmVycy9hY29ybiBkcml2ZXJzL2Fjb3JuL3Njc2kgZHJpdmVy
cy9tZXNzYWdlIGRyaXZlcnMvbWVzc2FnZS9mdXNpb24gZHJpdmVycy9tZXNzYWdlL2kybyBuZXQv
aXB4IG5ldC9kZWNuZXQgZHJpdmVycy9hY29ybi9uZXQgZHJpdmVycy9hdG0gZHJpdmVycy9zMzkw
IGRyaXZlcnMvczM5MC9uZXQgbmV0L2F4MjUgbmV0L2lyZGEgZHJpdmVycy9pc2RuIGRyaXZlcnMv
dGVsZXBob255IG5ldC9ibHVldG9vdGgiCgpMSUJESVJTPSJuZXQvYmx1ZXRvb3RoIG5ldC9ibHVl
dG9vdGgvYm5lcCIKTElCRklMRVM9Im5ldC9ibHVldG9vdGgvYm5lcCIKCiMgbWtkaXIgZm9yIGVh
Y2ggRElSUyBhbmQgdG91Y2ggZGlyL0tjb25maWcKZm9yIGRpciBpbiAkRElSUyA7IGRvCglpZiBb
ICEgLWQgJGRpciBdOyB0aGVuCgkJbWtkaXIgJGRpcgoJZmkKCWlmIFsgISAtZiAkZGlyL0tjb25m
aWcgXTsgdGhlbgoJCXRvdWNoICRkaXIvS2NvbmZpZwoJZmkKZG9uZQoKIyBta2RpciBmb3IgZWFj
aCBMSUJESVJTCmZvciBkaXIgaW4gJExJQkRJUlMgOyBkbwoJaWYgWyAhIC1kICRkaXIgXTsgdGhl
bgoJCW1rZGlyICRkaXIKCWZpCmRvbmUKCiMgdG91Y2ggTWFrZWZpbGUubGliIGZvciBlYWNoIExJ
QkZJTEVTCmZvciBkaXIgaW4gJExJQkRJUlMgOyBkbwoJaWYgWyAhIC1mICRkaXIvTWFrZWZpbGUu
bGliIF07IHRoZW4KCQl0b3VjaCAkZGlyL01ha2VmaWxlLmxpYgoJZmkKZG9uZQoKIyMjCg==

--Multipart_Thu__1_May_2003_17:09:58_-0700_09469b20--
