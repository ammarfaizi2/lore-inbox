Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUIIS3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUIIS3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIIS1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:27:22 -0400
Received: from mx02.qsc.de ([213.148.130.14]:20191 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S266631AbUIISJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:09:50 -0400
Date: Thu, 09 Sep 2004 20:09:22 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
Message-ID: <41409C52.nail3E31PZOBN@pluto.uni-freiburg.de>
References: <41323AD8.7040103@namesys.com>
 <413E170F.9000204@namesys.com>
 <Pine.LNX.4.58.0409071658120.2985@sparrow>
 <200409080009.52683.robin.rosenberg.lists@dewire.com>
 <20040909090342.GA30303@thunk.org>
In-Reply-To: <20040909090342.GA30303@thunk.org>
User-Agent: nail 11.7pre 9/9/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:

> Any such scheme will violate POSIX and SUS, since we are stealing from
> the filename namespace,

Not forcibly. POSIX does not give guarantees that everybody can access
existing files with arbitrary names. If there is a metafile in a directory
which can be looked up using the regular pathname hierarchy but requires
certain conditions to be accessed, there is principally nothing wrong
with this. It would likely be wrong if accessing the name for a
non-existent metafile using one of the POSIX interfaces (e.g. creat())
would result in other than one of the defined actions.

> and thus could cause a previously working program to stop working

POSIX holds a barrier against this. It just does not work using the
pathname resolution specification alone. It works by defining certain
actions for certain file type/system interface combinations. For
example, it is demanded that chdir() fails with ENOTDIR if the target
name is not a directory. Thus if the target is a regular file, chdir()
is required to fail.

If, however, the type of the file in question is neither S_IFREG
nor S_IFDIR nor another of the standardized file types, there are
no prescriptions about what system interfaces must do on them.
POSIX (IEEE Std 1003.1, 2004 Edition) explicitly allows to support
non-standard file types in its Base Definitions, 3. 'Definitions',
3.163 'File'.

Also (Base Definitions, 2.1 'Implementation Conformance', 2.1.1
'Requirements'):

# 4. The system may provide additional utilities, functions, or facilities
#    not required by IEEE Std 1003.1-2001. Non-standard extensions of the
#    utilities, functions, or facilities specified in IEEE Std 1003.1-2001
#    should be identified as such in the system documentation. Non-standard
#    extensions, when used, may change the behavior of utilities, functions,
#    or facilities defined by IEEE Std 1003.1-2001. The conformance document
#    shall define an environment in which an application can be run with the
#    behavior specified by IEEE Std 1003.1-2001. In no case shall such an
#    environment require modification of a Strictly Conforming POSIX
#    Application (see Strictly Conforming POSIX Application ).

For example, Unix domain sockets were not part of POSIX until 2001,
but none of the existing systems violated POSIX by refusing to open()
them.

I'm not sure about the results of pathname lookup using the names of
such implementation-defined file types with slashes attached, but it
would probably be worth to file an interpretation request for this
once there is sufficient demand to support it in Linux.

> --- however, assuming that we don't care about
> this, the virtical bar is the least likely to collide with existing
> file usages, because of its status as a shell meta-character (i.e.,
> pipe).  This means that in order to use it on the shell command line,
> programs will have to quote it:
>
> 	cat /home/tytso/word.doc/\|/meta/silly-stupid-metadata-or-named-stream

POSIX certainly requires this to fail with ENOTDIR if 'word.doc' is
S_IFREG, but if it is something like S_IFSTR, there might be a realistic
chance to have it as an implementation extension without violating POSIX.

	Gunnar

-- 
http://omnibus.ruf.uni-freiburg.de/~gritter
