Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWEPOyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWEPOyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEPOyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:54:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbWEPOyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:54:20 -0400
Date: Tue, 16 May 2006 07:54:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bernd Schmidt <bernds_cb1@t-online.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luke.yang@analog.com, gerg@snapgear.com
Subject: Re: Please revert git commit 1ad3dcc0
In-Reply-To: <4469E1AF.7040908@t-online.de>
Message-ID: <Pine.LNX.4.64.0605160740070.3866@g5.osdl.org>
References: <4469B63B.6000502@t-online.de> <20060516065848.13028f9f.akpm@osdl.org>
 <4469E1AF.7040908@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 May 2006, Bernd Schmidt wrote:
> 
> It's not the get_file that's the problem, it's the get_unused_fd and
> fd_install.  These files are now open while the process lives and consume file
> descriptors. 

Side note: this would be a valid argument, except it's not always true. 
I'm not sure why Luke wanted the fd in the first place, though, and 
whether we want it.

Some loaders may actually want the fd value, see for example themisc 
loader and MISC_FMT_OPEN_BINARY, and the ELF loader _does_ actually do it 
for the (interpreter_type == INTERPRETER_AOUT) case.

So it's certainly not a new concept, and other loaders do the exact same 
thing. 

Whether the flat loader should do it (or under what circumstances it 
should do it), I just can't make any judgement. More information needed.

> Before the change, we didn't allocate or install a file descriptor, hence
> there wasn't any reason to return EMFILE.  The spec at
>   http://www.opengroup.org/onlinepubs/009695399/functions/exec.html
> doesn't list EMFILE as a possible error.

Totally irrelevant.

A lot of system calls will return errors other than the ones listed. The 
text says "shall fail if", which just means that those errors are 
_required_ to happen under the circumstances listed (and you can't use 
other errors _for_those_particular_circumstances_).

See

	http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html#tag_02_03

  "Implementations may support additional errors not included in this 
   list, may generate errors included in this list under circumstances 
   other than those described here, or may contain extensions or 
   limitations that prevent some errors from occurring. The ERRORS section 
   on each reference page specifies whether an error shall be returned, or 
   whether it may be returned. Implementations shall not generate a 
   different error number from the ones described here for error 
   conditions described in this volume of IEEE Std 1003.1-2001, but may 
   generate additional errors unless explicitly disallowed for a 
   particular function."

for more.

		Linus
