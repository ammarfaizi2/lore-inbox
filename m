Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUCGPKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 10:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUCGPKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 10:10:25 -0500
Received: from main.gmane.org ([80.91.224.249]:34752 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262087AbUCGPKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 10:10:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: External kernel modules, second try
Date: Sun, 07 Mar 2004 18:09:55 +0300
Message-ID: <pan.2004.03.07.15.09.54.765466@altlinux.ru>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078666334.3594.31.camel@nb.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Cc: kbuild-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2004 14:32:14 +0100, Andreas Gruenbacher wrote:

> Now with mainline, when building external modules they will end up not
> having modversions. This is caused by the way .tmp_versions is handled,
> and is a real problem. There are two different ways how we are building
> external modules today:
> 
>   (1) after the kernel source tree was just compiled, so the kernel
>       source tree still contains all the object files,
> 
>   (2) in a separate step, against an almost clean kernel source tree.
>       Almost-clean means the tree contains a set of configuration files,
>       and the modversions dump file.
> 
> The modversions dump file elegantly solves both cases.

However, one little problem still remains: What if external modules from
one package need to use symbols from modules which are also external, but
in a different package?  We have a similar situation in 2.4.x with lirc
modules, which reference symbols from bttv (and bttv is built in a
separate package together with some other out-of-tree v4l modules, because
they need a common tuner module).

Suggestions:

- Create a subdirectory for modversions dump files (the dump file for the
  kernel will go into modversions/kernel).

- Allow multiple "-i DUMPFILE" options in modpost.  Wildcard handling will
  be in the Makefiles:

	modver_files := $(wildcard $(srctree)/modversions/*)
	modpost_input_flags := $(addprefix -i ,$(modver_files))

- Make "-o NEWDUMPFILE" work properly even after "-i DUMPFILE" (mark all
  symbols which were read from a dump file and do not output such symbols
  when writing the new dump file).

- Add a way to specify the output dump filename for modpost when building
  external modules.


