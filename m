Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132962AbRDJKq0>; Tue, 10 Apr 2001 06:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDJKqQ>; Tue, 10 Apr 2001 06:46:16 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:7951 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132962AbRDJKqA>;
	Tue, 10 Apr 2001 06:46:00 -0400
Date: Tue, 10 Apr 2001 06:47:00 -0400
Message-Id: <200104101047.f3AAl0h07395@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.0.0 release announcement
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After 11 months of painstaking work and testing, CML2 1.0.0 is ready for use,
and ready to replace the current kernel-configuration system.  You'll
find it at <http://www.tuxedo.org/~esr/cml2/>.  I've made a transition
guide available at <http://www.tuxedo.org/~esr/cml2/transition.html>.

(Why this project at all?  For those of you who don't remember, it all
started when I realized that building kernels is way too hard.  I
wanted to simplify the configuration task enough to make configuration
accessible to non-gurus.  It needs to have more policy options.
Rather than hundreds of questions like "Include FOOBAR2317 driver?",
the novice should see stuff like "Compile in all modular drivers as
modules without prompting?")

On 30 March 2001 at the Kernel Summit, Keith Owens and I worked out a
transition schedule with Linus.  Keith's rewrite of the makefile system and
my configurator tools are officially slated to replace the present system in
the 2.5.1 to 2.5.2 timeframe.  That, of course, is contingent on us not
screwing up :-).

(For those of you who grumbled about adding Python to the build-tools set,
Linus has uttered a ukase: CML2's reliance on Python is not an issue.  I have
promised that once CML2 is incorporated I will actually *reduce* the kernel
tree's net dependence on external tools, and I know exactly how to deliver on
that promise.)

Linus opted for a sharp cutover rather than a gradual transition -- when the
new stuff goes into the tree, CML1 will drop dead immediately.  Configuration
maintainers should be prepared!  Right now, any errors in my translation of
the CML1 rules are my problem -- but after Der Tag, they will swiftly become
*your* problem.  We'll all be happier if you have flamed my butt and helped
me fix any problems well in advance of the cutover.

The rules files in this release have been re-checked against the 2.4.3
tree.  While I can't guarantee they are completely correct (that's
your job), they at least cover every CML1 symbol.  I have written coverage
tools to check this.  There is still a problem with the  CRIS port symbols
that lack a CONFIG_ prefix, but the CRIS people say they'll fix that in their
next update.

The stock CML2 distribution contains an installation script which will drop
CML2 in place on a current kernel tree.  At most one existing file (your
top-level Makefile) will be touched, with new versions of the
config/oldconfig/menuconfig/xconfig productions edited in.  (The old ones
will be kept under variant names, so you can still invoke CML1 if you
want.)

I've learned, the hard way, that kernel developers are a conservative
bunch.  So, to help you all feel better about the change, here are
some of the improvements CML2 offers over the existing CML1
configuration system:

Maintainability:

* Where CML1 had three different interpreters, none perfectly compatible with
  any of the others, CML2 has *one* rule compiler and *one* rulebase-
  interpreter front end.  This will be good for consistency and economy.

* As of CML2 1.0.0 and CML1 2.4.3, the combined code and data size in lines
  of the system (a good indicator of its maintainability) shrank by 38%.  For
  code alone the figure was 43%.  Furthermore, where CML1 was written in a
  weird mix of three languages, CML2 uses exactly one.

* CML2 decouples the configuration language from the configuration user
  interface (they communicate with each other only through the compiled
  rulebase).  This means that it will be relatively easy to improve the
  UI and the language separately.

* CML2 has a track record.  It is already being used in other projects,
  including most notably the Embedded Debian Project.  Adam Lock at Netscape
  is using it to construct a tool for configuring Mozilla builds.

Programmer Friendliness:

* The rather spiky and cluttered shell-like syntax of CML1 is replaced
  with a much simpler and more regular format resembling that of .netrc or
  .fetchmailrc.  More importantly, the semantics of the language are
  declarative rather than imperative -- a better match for the problem
  domain, and thus more expressive and easier to code in.

* CML2 will eliminate (or at least drastically reduce) skew between port
  configurations.  The fact that the top-level CML1 files of the fifteen
  ports in the kernel tree are separate means there have been plenty of
  opportunities for the common code in them to drift apart; CML2's design
  and compilation rules should effectively prevent future bugs of this kind.

* CML2 query prompts and menu banners are separated from the symbol
  dependency declarations.  Thus CML2 system definitions can be 
  internationalized and localized.

* CML2 has a complete, explicit description.  Syntax, language semantics,
  and user-interface options are all discussed in detail.  

User Experience:

* In CML2 it is impossible to generate a configuration that is
  invalid according to the rules file(s).  You'll get a popup complaining
  about the constraint that was violated if you try.  (This is effect #1
  of having a theorem prover in the configurator.)

* Whenever CML2 can deduce from a symbol tweak that other changes are
  required, it does them.  And if the change is reversed, so are all
  those side effects. (This is effect #2 of having a theorem prover
  in the configurator.)  The user interfaces tell you what the side effects
  are.

* All three interfaces do progressive disclosure -- the user only sees
  questions he/she needs to answer (no more hundreds of greyed-out menu
  entries for irrelevant drivers!).

* The declarative semantics of CML2 makes it much easier to set up
  and check options for policy-based configuration.  I have done only 
  enough of this in the CML1 translation for demonstration purposes (there
  are new symbols TUNING, EXPERT and WIZARD that change some visibilities).
  Once CML2 is in place, it should be a relatively small effort to
  give the user a rich set of policy and don't-bother-me options.

* The line-oriented mode of the new configurator is much more powerful
  than the original Configure. It's possible to move backward or jump
  around in the configuration sequence.

* The new curses mode, unlike the old menuconfig code, has full access
  to the help texts.

* All URLs in the Tkinter version's help windows are now live; if you
  click on them they'll launch a browser.

* Curses and Tk interfaces now use color as a navigational aid -- both in the
  same way so the user interface is consistent.

* And a cool penguin logo when we iconify the X version! :-)

Many linux-kernel regulars have helped develop, test, and debug CML2,
including Giacomo Catenazzi, David Kamholz, Robert Wittams, Randy
Dunlap, Urban Widmark, Andr� Dahlqvist, Drago Goricanec, William
Stearns, and Gary Lawrence Murphy.





-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The common argument that crime is caused by poverty is a kind of
slander on the poor.
	-- H. L. Mencken
