Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbRFWPbC>; Sat, 23 Jun 2001 11:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264135AbRFWPaw>; Sat, 23 Jun 2001 11:30:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55058 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264122AbRFWPai>;
	Sat, 23 Jun 2001 11:30:38 -0400
Date: Sat, 23 Jun 2001 16:30:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Der Herr Hofrat <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
Message-ID: <20010623163026.A27303@flint.arm.linux.org.uk>
In-Reply-To: <200106231454.f5NEsKu14812@kanga.hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106231454.f5NEsKu14812@kanga.hofr.at>; from der.herr@hofr.at on Sat, Jun 23, 2001 at 04:54:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2001 at 04:54:20PM +0200, Der Herr Hofrat wrote:
> struct { short x; long y; short z; }bad_struct;
> struct { long y; short x; short z; }good_struct;
> 
> I would expect both structs to be 8byte in size , or atleast the same size !
> but good_struct turns out to be 8bytes and bad_struct 12 .
> 
> what am I doing wrong here ?

You're expecting the compiler to lay them out without any spacing between
them.  There is no such requirement in C.

The compiler knows that its more efficient for long words to be accessed
on a long word boundary, so it wastes two bytes after each short in your
bad_struct case.  However, it won't waste them in this case, because there
isn't a long:

struct { short x; short y; short z; }

If you really really really want that layout, then use
__attribute__((packed)) (read the gcc info files to find out what this
does), but don't unless you absolutely must.

Here is another struct layout example:

struct foo {
	short x;
	char y;		/* implicit 1 byte padding after this element */
	short z;
};

Again, the 1 byte padding can be removed by use of the __attribute__
above.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

