Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWCEUHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWCEUHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCEUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:07:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29834 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751812AbWCEUHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:07:03 -0500
Date: Sun, 5 Mar 2006 20:06:59 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Keith Ownes <kaos@ocs.com.au>
Subject: Re: kbuild - status on section mismatch warnings
Message-ID: <20060305200659.GD27946@ftp.linux.org.uk>
References: <20060305193012.GA14838@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305193012.GA14838@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 08:30:12PM +0100, Sam Ravnborg wrote:
> During the last weeks I have worked on improved support for section
> mismatch checks.
> 
> When a function is marked __init then the implementation will be placed
> in a section named .init.text - that section will be discarded by
> vmlinux when the module is initialised.
> So therefore any references to function marked __init are subject to
> references to functions that may suddenly disappear.
 
Now try x86 with sd.o non-modular.  And see


__init foo()
{
....
	switch(n) {
	....
	....
	}
}

compiling essentially into

	if (n < lower || n > upper)
		goto Ldefault;
	addr = const_array_of_labels[n - lower];
	goto addr;

with const_array_of_labels sitting in .rodata and its contents pointing
inside foo(), i.e. into .init.text.  And yes, .init.text is discarded,
while .rodata is left intact.  Since the only reference to that array
disappears along with .init.text *and* section where array goes into is
hardwired into gcc, we
	a) are actually OK and
	b) can't do anything about that false positive, AFAICS.
