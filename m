Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHNHT>; Thu, 8 Feb 2001 08:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBHNHJ>; Thu, 8 Feb 2001 08:07:09 -0500
Received: from mail.zmailer.org ([194.252.70.162]:14852 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129033AbRBHNGy>;
	Thu, 8 Feb 2001 08:06:54 -0500
Date: Thu, 8 Feb 2001 15:06:32 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: DNS goofups galore...
Message-ID: <20010208150632.K15688@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

  Do inform your DNS administrators that they better do things
correctly, or email won't work.  (Nor much else..)

Some people are telling around heretic information that it is
all right to use IP(v4) address literal TEXT in places which
are intended for NAMES.

As a result, the mind-set of "address is ok here" leads to nasty
surprises with $ORIGIN append rules, etc.   See below and deduce
what is missing from the original zone file.  Answer at the end.

As I got today two of these goofups in bounce reports, I decided
to write a bulletin to get your attention of wrong information
being floated around:


    -- Lookup of MX/A for 'cyclades.com'
    -> DNSreply: len=171 rcode=0 qd=1 an=1 ns=3 ar=3
    -> 84802s MX[0] p=10 '209.81.55.2.cyclades.com'
    -> getaddrinfo(INET, '209.81.55.2.cyclades.com','0') -> r=-5 (no address associated with name); ai=%p
    -> No addresses for '209.81.55.2.cyclades.com'[0]
    -> nmx=1 maxpref=66000 realname=''
    => NONE of MXes support SMTP!

    -- Lookup of MX/A for 'gsl.kralupy.cz'
    -> DNSreply: len=143 rcode=0 qd=1 an=1 ns=2 ar=2
    -> 85291s MX[0] p=10 '194.213.206.70.kralupy.cz'
    -> getaddrinfo(INET, '194.213.206.70.kralupy.cz','0') -> r=-2 (name or service is not known); ai=%p
    -> No addresses for '194.213.206.70.kralupy.cz'[0]
    -> nmx=1 maxpref=66000 realname=''
    => NONE of MXes support SMTP!


% dig mx cyclades.com
......
;; ANSWER SECTION:
cyclades.com.           1D IN MX        10 209.81.55.2.cyclades.com.

;; AUTHORITY SECTION:
cyclades.com.           1D IN NS        209.81.55.2.cyclades.com.
cyclades.com.           1D IN NS        209.81.59.2.cyclades.com.
cyclades.com.           1D IN NS        209.81.9.151.cyclades.com.
cyclades.com.           1D IN NS        200.230.227.66.cyclades.com.
......

% dig mx gsl.kralupy.cz
......
;; ANSWER SECTION:
gsl.kralupy.cz.         1D IN MX        10 194.213.206.70.kralupy.cz.

;; AUTHORITY SECTION:
kralupy.cz.             1D IN NS        kpy01.kralupy.cz.
kralupy.cz.             1D IN NS        sa.kra.cesnet.cz.
......


  In case of  cyclades.com  the DNS administrator has made a double
mistake by listing IP addresses also in NS pointers -- while the usual
resolver codes use  gethostbyname() (or getaddrinfo()), the DNS servers
are different animals alltogether.

The IPv4 address-LIKE data in MX records works mostly due to (an unhappy)
coincidence in the usual BSD/bind resolver libraries, where gethostbyname()
has also habit of parsing address literal to binary address.

NSes and MXes must ALWAYS point to NAMEs with A/AAAA/A6 records for
them, specifically those names MUST NOT be CNAMEs.   With NSes the
proper glue resolving is even more important.  The DNS servers won't
work quickly if they need to go fishing pointer data far and wide.

Indeed they will abandon the search quite soon if resolving needs
very deep recursions (more than 2-3 levels) for things like "to find
the NSes for zone X one looks up zone Y NSes, learns that they are
pointing to zone Z, looks it up and is delegated to zone W, now finding
Address of DNS server of Z, asking it, finding address of NS of Y,
asking there data for zone X ...

Now you think that nobody can be that stupid.
Unfortunately that is quite common.

Therefore (the thinking goes) having IP address literals in place of
Domain Names will short the resolving path, and yield quicker convergence.
Nice, but for NS pointers it doesn't matter what you put into your own
zone, only what is on the zone ABOVE yours will matter.


Always do suspect your own (email) DNS setup, stupidities like these
above are creeping around.


How VGER sees your DNS setup situation can be asked from web-page:

  http://vger.kernel.org/mxverify.html

by giving your email address there.



Answer to the self-education question above:

  The NAME fields in usual BIND systems get appended the current $ORIGIN
  string value when the data in the field does not end with a dot:

  Wrong:     IN MX 10  11.22.33.44
  "Right":   IN MX 10  11.22.33.44.

  The second appears at DNS lookup as "IN MX 10 11.22.33.44", which
  is the intention aiming to use quite common misfeatures of system
  libraries.  THERE IS NO GUARANTEE OF IT WORKING AT NON-UNIX SYSTEMS!
  Indeed there is no guarantee of it working at UNIX systems either!

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
