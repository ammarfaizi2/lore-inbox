Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVJHBfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVJHBfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVJHBfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:35:12 -0400
Received: from free.hands.com ([83.142.228.128]:50063 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932108AbVJHBfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:35:10 -0400
Date: Sat, 8 Oct 2005 02:34:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Cc: Linux Visionaries Mailing List <lvml@lists.blackwhale.net>
Subject: Re: Why no XML in the Kernel?
Message-ID: <20051008013457.GR18797@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a requirement to pass information from the kernel to user space.
> The information is passed fairly rarely, but over time extra parameters
> are added. At the moment we just use a struct, but that means that the
> kernel and the userspace app have to both keep in step. If something
> like XML was used, we could implement new parameters in the kernel, and
> the user space could just ignore them, until the user space is upgraded.
> XML would initially seem a good idea for this, but are there any methods
> currently used in the kernel that could handle these parameter changes
> over time.

 okay.

 storing data in binary format is efficient space-wise, clearly
 optimal, but is difficult to interpret unless you play a lot
 of chess and music.

 XML is inefficient memory and processing wise for storage of
 data, but it is structured, is easy for normal humans to read and
 understand as long as microsoft doesn't get their hands on it.

 the guy who wrote XMLRPC more than 5 or so years ago did so as
 an experiment in order to get himself onto the SOAP committee.

 now we have .NET, based on SOAP, and everyone hates it.  them.
 .NET _and_ SOAP.  even if SOAP _can_ be implemented in 6,000 lines
 of python.


 ramming structs in home-grown marshalled format across
 processes is fine (i do it all the time) ...

 ... until you get large complex data structures, see this url
 for an example of horrendously complex multi-linked-listed,
 multi-unioned interlinked and _recursive_ data structures
 with forward references, that would be a complete nightmare
 without automated tools:

 http://cvs.sourceforge.net/viewcvs.py/oser/exchange5.5/exploration/test/emsabp/emsabp.idl?rev=1.1&view=markup

 if it wasn't for freedce, the creation of, management and
 use of such data structures would be a complete nightmare.

 no i do _not_ recommend that freedce be used inside the linux kernel.

 however what i _would_ advocate for special and specific
 circumstances would be to seek out the "pickling" side of
 freedce, run the IDL compiler and end up with some c-code
 that can then be used as a form of structured storage:

	 http://www.opengroup.org/tech/rfc/mirror-rfc/rfc2.1.txt
	
 it's a bit of a pain that the code generated stuffs 20 bytes
 of garbage (the uuid and version number that you specified
 in the .idl file) but that can always be stripped off after
 encoding and re-added manually at decode time (or the code in
 freedce just chiselled away) - all you lose by following that
 trick is the unpickling code's ability to tell you "yes, you
 handed me the wrong blob there, bob".  as a result, faking
 up the version number and uuid on the wrong blob will trash
 your function call stack - just in the same way as if you
 got a printf with the wrong number of arguments.

 what OSF call "pickling" is also known as persistent or structured
 storage.

 it's a friggin sight better than contemplating XML, but it also comes
 with a price tag: in this case, nearly 70,000 lines of library code
 that "encapsulates" and "extracts" the data structures for you, at
 runtime [yes, you can supply your own malloc and free routines]

 in the cases where data structures are _that_ complex, or where time is
 of the essence, or you have a significant amount of regular restructuring
 anticipated before settling on your final data structures and APIs, the
 use of an automated "pickler" - one that does binary NOT some stupid
 XMsmelly format - is a good idea.

 where it's NOT a good idea is where you have _really_ simple data
 structures, or your data structures simply ain't gonna change much
 ever, or you have exceptionally careful programmers who have lots of
 time on their hands to go over each line of the hand-marshalling and
 unmarshalling code, line-by-line.

 and yes, as i understand it, the GNU/Hurd has so much structured
 storage passing going on that yes, they wrote an IDL compiler and a
 mini RPC system (oh, and they have microkernel to make use of it,
 too.  nyer :)

 one of these fine decades i will experiment with using
 freedce instead of their home-grown IDL compiler and see if
 it's possible to utilise freedce networking to move entire
 processes, uninterrupted, from one machine to another.

 basically, these tools allow the specialist job of turning complex data
 structures into data streams and back again to be separated from the
 specialist job of writing a decent kernel.

 if your data structures aren't that complex, you really _don't_ need
 specialist tools - XML or binary.

 l.

 p.s. hurrah!  first post on LVML :)

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
