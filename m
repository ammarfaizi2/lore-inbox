Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319172AbSHNCWa>; Tue, 13 Aug 2002 22:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319180AbSHNCWa>; Tue, 13 Aug 2002 22:22:30 -0400
Received: from rj.sgi.com ([192.82.208.96]:30892 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319172AbSHNCW3>;
	Tue, 13 Aug 2002 22:22:29 -0400
Message-ID: <3D59BFF5.2C3B4B6A@alphalink.com.au>
Date: Wed, 14 Aug 2002 12:27:01 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <3D587483.1C459694@alphalink.com.au> <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu> <20020813204829.GJ761@cadcamlab.org> <3D59B212.DC24E231@alphalink.com.au> <20020814014241.GK761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Greg Banks]
> > Does "complete" mean all the ports have also made the change and
> > been merged back?
> [...]
> Actually I suspect it would be more like the C99 thing: after the new
> syntax is added, we start doing [TRIVIAL] patches to clean out the
> old, and eventually once that is done we have the option of removing
> the old syntax or leaving it in as a known oddity. [...]

Fair enough.

> > I'm more concerned about subtle dependencies on execution order
> > resulting from misuse of conditionals.
> 
> Yeah, that's the real reason 'n'!='' is Considered Harmful (and warned
> about in the docs even now).

There are issues regardless of the behaviour of "".   For example, here's
one of at least 8 ways I've identified where things can go wrong when
conditionals are misused.

#
# Testing mixed overlap, type 1
# (mixed overlap, define first, query conditional, same menu)
#

mainmenu_option next_comment
comment 'xconfig needs this menu'

    define_bool CONFIG_QUUX y

    bool 'Set this symbol to ON' CONFIG_FOO

    if [ "$CONFIG_FOO" = "y" ]; then
	bool 'Here QUUX is a query symbol' CONFIG_QUUX
    fi

endmenu

# Expected semantics:
# FOO=n => QUUX not asked, is y.
# FOO=y => QUUX asked, default y, can be either y or n.
# so list of valid configs is:
#   QUUX=y FOO=n
#   QUUX=y FOO=y
#   QUUX=n FOO=y

# Actual semantics, "make config"
# FOO=n => QUUX not asked, is y (CORRECT)
# FOO=y => QUUX asked, default y,
#   	   if y appears twice with same value (INCORRECT)
#          if n appears twice with different values (INCORRECT)
# list of produced configs:
#   QUUX=y FOO=n
#   QUUX=y FOO=y QUUX=y
#   QUUX=y FOO=y QUUX=n

# Actual semantics, "make menuconfig"
# FOO=n => QUUX not asked, is y (CORRECT)
# FOO=y => QUUX asked, default y,
#   	   if y appears twice with same value (INCORRECT)
#          cannot set to n (INCORRECT)
# list of produced configs:
#   QUUX=y FOO=n
#   QUUX=y FOO=y QUUX=y

# Actual semantics, "make xconfig"
# FOO=n => QUUX not asked
#   	   on save, get "ERROR - Attempting to write value for unconfigured variable (CONFIG_QUUX)"
#          does not save QUUX at all (INCORRECT)
# FOO=y => QUUX asked, default y,
#   	   if y appears twice with same value (INCORRECT)
#   	   cannot set to n (INCORRECT)
# list of produced configs:
#   FOO=n
#   QUUX=y FOO=y QUUX=y

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
