Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRKDVDS>; Sun, 4 Nov 2001 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278839AbRKDVDJ>; Sun, 4 Nov 2001 16:03:09 -0500
Received: from unthought.net ([212.97.129.24]:1497 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S278829AbRKDVC7>;
	Sun, 4 Nov 2001 16:02:59 -0500
Date: Sun, 4 Nov 2001 22:02:58 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104220258.X14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20011104211153.V14001@unthought.net> <625740430.1004906873@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <625740430.1004906873@[195.224.237.69]>; from linux-kernel@alex.org.uk on Sun, Nov 04, 2001 at 08:47:53PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 08:47:53PM -0000, Alex Bligh - linux-kernel wrote:
> >> Using a ioctl that returns the type.
> >
> > But that's not pretty   :)
> >
> > Can't we think of something else ?
> 
> Well this sure isn't perfect, but to
> illustrate it can be done with a text
> interface (and the only restriction
> is strings can't contain \n):

Such limitations are not acceptable.

> 
> cat /proc/widget
> # Format: '%l'
> # Params: Number_of_Widgets
> 37
> 
> echo '38' > /proc/widget
> 
> cat /proc/widget
> # Format: '%l'
> # Params: Number_of_Widgets
> 38

Good point with the parsing  :)

> 
> cat /proc/widget | egrep -v '^#'
> 38
> 
> cat /proc/sprocket
> # Format: '%l' '%s'
> # Params: Number_of_Sprockets Master_Sprocket_Name
> 21
> Foo Bar Baz

Not one value per file ?

> 
> echo '22' > /proc/sprocket
> # writes first value if no \n character written before
> # close - all writes done simultaneously on close
> 
> cat /proc/sprocket | egrep -v '^#'
> 22
> Foo Bar Baz
> 
> echo 'Master_Sprocket_Name\nBaz Foo Bar' > /proc/sprocket
> 
> cat /proc/sprocket | egrep -v '^#'
> 22
> Baz Foo Bar
> 
> echo 'Master_Sprocket_Name\nFoo Foo Foo\nNumber_of_Sprockets\n111' > 
> /proc/sprocket
> # Simultaneous commit if /proc driver needs it
> # i.e. it has get_lock() and release_lock()
> # entries
> cat /proc/sprocket | egrep -v '^#'
> 111
> Foo Foo Foo
> 
> & nice user tools look at the '# Params:' line to find
> what number param they want to read / alter.

How about:

We keep old proc files.

For each file, we make a .directory.

For example - for /proc/meminfo, we make a /proc/.meminfo/ directory
that contains the files
 MemTotal
 MemFree
 MemShared
 etc.

cat /proc/.meminfo/MemTotal gives you
"u32:KB:513276"

The kernel code for printing this is something like
 sprintf(..., "%s:%s:%u", DPI_T_U32, DPI_U_KB, i.memtotal);

The types and the units are necessary. But furthermore we do not
want various developers to be using different ways of writing the
types and units (KB vs. kB, vs. KiB).  Defines will ensure that
(if they are used - but they lend themselves to being used), and
once a new define is introduced it is fairly easy to document and
export to userland.

Not only does this format tell us exactly what's in the file (and
therefore how we should parse it), it also defines what we can write
to it (assuming we write the same types as we read - but that's a
reasonable assumption I suppose).

Problem:  Could it be made simpler to parse from scripting languages,
without making it less elegant to parse in plain C ?

If the values is a string, the string will begin after the second
semicolon (safe, since no type or unit can contain a colon and won't
have to, ever), and ends at the end of the file.  Voila, any character can be
in the string value.

And Al gets his #%^# text files   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
