Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUDUOWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUDUOWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUDUOWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:22:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262953AbUDUOW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:22:29 -0400
Date: Wed, 21 Apr 2004 15:22:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       Matt Tolentino <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add some EFI device smarts
Message-ID: <20040421142228.GM18329@parcelfarce.linux.theplanet.co.uk>
References: <200404201600.26207.bjorn.helgaas@hp.com> <20040420235038.GB29850@lists.us.dell.com> <200404210659.22884.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210659.22884.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 06:59:22AM -0600, Bjorn Helgaas wrote:
> > > +		/* Convert Unicode to normal chars */
> > > +		for (i = 0; i < (name_size/sizeof(name_unicode[0])); i++)
> > > +			name_utf8[i] = name_unicode[i] & 0xff;
> > > +		name_utf8[i] = 0;
> > 
> > I've never had a clear understanding of this.  It's not really UTF8
> > (else straight ASCII text could be used), but more like UCS2.
> 
> I don't understand Unicode either.  Maybe the attached is a little
> closer?  The EFI spec (1.10, table 2-2) says strings are stored in
> UTF-16, and I think that UTF-16 is the same as ASCII for
> (0 < c <= 0x7f).

Ah, I know this one ...

UTF-16 is like UCS-2 except that it has escapes to let you use past the
first plane of Unicode.  That is, by and large it's 2-bytes long, but
sometimes it can be 4 or more bytes long.  How to convert?  Let's see ...

	for (i = 0, j = 0; i < (name_size/sizeof(name_unicode[0])); i++) {
		unsigned int rune = name_unicode[i];
		if (0xD7FF < rune && rune < 0xE000) {
			rune = (rune & 0x7ff) << 10;
			rune |= name_unicode[++i] & 0x3ff;
		}
		if (rune < 0x80) {
			name_utf8[j++] = rune;
		} else if (rune < 0x800) {
			name_utf8[j++] = 0xc0 | (rune >> 6);
			name_utf8[j++] = 0x80 | (rune & 0x3f);
		} else if (rune < 0x10000) {
			name_utf8[j++] = 0xe0 | (rune >> 12);
			name_utf8[j++] = 0x80 | ((rune >> 6) & 0x3f);
			name_utf8[j++] = 0x80 | (rune & 0x3f);
		} else {
			name_utf8[j++] = 0xf0 | (rune >> 18);
			name_utf8[j++] = 0x80 | ((rune >> 12) & 0x3f);
			name_utf8[j++] = 0x80 | ((rune >> 6) & 0x3f);
			name_utf8[j++] = 0x80 | (rune & 0x3f);
		}
	}

ftp://ftp.rfc-editor.org/in-notes/rfc2279.txt
ftp://ftp.rfc-editor.org/in-notes/rfc2781.txt

Haven't even tried to compile it ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
