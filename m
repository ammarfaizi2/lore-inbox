Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbRL1T3o>; Fri, 28 Dec 2001 14:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286992AbRL1T1s>; Fri, 28 Dec 2001 14:27:48 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:65497
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286993AbRL1T1d>; Fri, 28 Dec 2001 14:27:33 -0500
Date: Fri, 28 Dec 2001 14:12:11 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228141211.B15338@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228042648.A7943@havoc.gtf.org> <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 10:02:01AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>:
> My pet peeve is "centralized knowledge". I absolutely detested the first
> versions of cml2 for having a single config file, and quite frankly I
> don't think Eric has even _yet_ separated things out enough - why does the
> main "rules.cml" file have architecture-specific info, for example?

I'm not certain what you're objecting to, and I want to understand it.
There are rules that use architecture symbols to suppress things like
bus types.  I presume that's not a problem for you, but tell me if it is.

My best guess is that you're objecting to the archihacks and kernelhacking
menus, or the architecture-dependent derivations down around line 330.

In general what's going on here is actually the beginnings of an attempt to 
replace architecture-dependent questions with architecture-*independent*
questions.  It looks kind of ugly right now because it's too early in
the game to mess with the config-symbol namespace -- but, for example, I
want to merge the MATH_EMULATION and MATHEMU symbols eventually.  And 
there ought to be a generic set of toggles for kernel-debugging that
present to the user as cross-platform capabilities rather than platform-
specific switches.  

In those two menus I've gathered together architecture-specific
symbols that I think ought to merge into cross-platform capabilities.
But I know there is other cruft in there for historical reasons.  Since
you've brought up the point, I'll do a cleanup pass on these and see
how much I can exile to the arch/*/rules.cml files.

There isn't really any help for the ceoss-platform derivations.  There
are exactly four of these. I've worked hard at holding them to a
minimum:

derive HAVE_DEC_LOCK from (SMP and (ALPHA or X86_CMPXCHG)) or SPARC or PPC
derive HIGHMEM from HIGHMEM4G or HIGHMEM64G or SPARC
derive MAC_HID from (ALL_PPC and INPUT!=n) or (MAC and INPUT_ADBHID)
derive PC_KEYB from ARM_PC_KEYB or MIPS_PC_KEYB

If you notice that each right-hand part includes port symbols from at
least two different architectures, I think it will be clearer why these
are necessary. 

CML1's way of doing this had the problem that it was hard to know by
inspection of the rulebase under what circumstances a given symbol was
actually turned on.  This is why CML2 has a rule that each symbol is
derived (or occurs in a menu) exactly once.  With some work I could
relax this restriction, but I don't want to -- it's a major factor in
keeping the rulebase's complexity down in the range that a human brain
can mentally model.

> That's a big step backwards as far as I'm concerned - we didn't use to
> have those stupid global files, and each architecture could do it's own
> config rules. Eric never got the point that to me, modularity is _the_
> most important thing for maintenance.

Oh, no, I got that all right.  What I have been trying to do is trade
off correctly between modularity (which helps maintenance) and the
advantages to the configurator *users* of having a global capability
namespace, single-apex menu structure, and the symbols-to-prompts
mapping in one file.  These choices weren't made at random.

You don't readily see their advantages because you have a
nose-to-the-code, maintainer perspective (quite properly so, in most
cases).  But in designing the configuration system, simplifying life
for *users* is just as important, if not more so.  Sometimes this
implies not going as far in the direction you favor direction as you
might like (monolithic Configure.help is an example).

> Something I also asked for the config system at least a year ago was to
> have Configure.help split up. Never happened. It's still one large ugly
> file. Driver or architecture maintainers still can't just change _their_
> small fragment, they have to touch a global file that they don't "own".

Yes, there are two reasons for this.

The contingent, historical reason is that I wanted to get
Configure.help in good shape before thinking about dispersing it.
That work is now done (though you haven't kept up to date with it).

The design reason is that having a single file with all the symbol-to-prompt
mappings in it is really helpful when you want to localize the rulebase for
another language.  I'm still leaning towards keeping symbols.cml together
just to make it easier for people to do and distribute translations of it.

I think this is an issue that is rising in importance.  I have no problem
with assuming that kernel hackers are English-literate, but it's no longer
an assumption we should make about people *building* kernels.  I want
to encourage CML2 and question-string localizations for French.  And
German.  And Thai.  And Ethiopian.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

If I were to select a jack-booted group of fascists who are 
perhaps as large a danger to American society as I could pick today,
I would pick BATF [the Bureau of Alcohol, Tobacco, and Firearms].
        -- U.S. Representative John Dingell, 1980
