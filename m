Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312586AbSCVAyI>; Thu, 21 Mar 2002 19:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312588AbSCVAxw>; Thu, 21 Mar 2002 19:53:52 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:58896 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312586AbSCVAxb>; Thu, 21 Mar 2002 19:53:31 -0500
Date: Fri, 22 Mar 2002 01:53:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: kbuild-devel@lists.sourceforge.net, esr@thyrsus.com
Subject: alternative linux configurator specification v0.1
In-Reply-To: <3C94948E.777B5BAF@linux-m68k.org>
Message-ID: <Pine.LNX.4.21.0203212024520.28450-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Below is a first version of the specification, which describes the config
syntax as it's currently generated. It's not complete yet, but IMO ready
for a first review. If you want to see how it works, you can still do it
with http://www.xs4all.nl/~zippel/lc/lc-0.2.tar.gz.
Maybe I should also say, which kind of feedback I'd really like to
have. My main goal is to create a simple, but also easily extendable
configuration system. So before reading the spec below, try the package
and at least create the new configuration file. Then check it out and try
to understand it. Now compare your expectation with the spec below. How
does it compare? Any unpleasant surprises?
It's very important for me to avoid problems here, in the end all kernel 
developers have to maintain their configuration information and that is a
point, where I see problems with cml2. (So if you have experience with
cml2, some feedback on how it compares to this, would be of course welcome
too.)
cml2 has several interesting ideas, but IMO Eric skips a step. cml2 became
too complex while trying to implement all this, so I rather concentrate
on the essentially needed things.
Eric, I also would really like to get some feedback from you and your
opinion about this. You worked on this longer than I did. Which parts are
missing here? Can this be extended to describe this?
We really need to make an intermediate step, before we can implement any
new functionality. Your implementation does simply too much and not always
the right thing. Today I was playing with it again and only did a 'make
oldconfig' and it completely modified my configuration. Eric, this is
simply unacceptable. So please let's work on this together to get the
best out of it.

bye, Roman

-- 

A small overview about the current config language syntax. This syntax
describes all elements which are used by the converter to describe the
cml1 syntax. Every extension, which is currently understood, or any
assumptions made by the config frontends, is still unspecified and
likely to change.

Areas that need better specification:
- relation of multiple definition of the same config symbol (also if one
  definition is part of a choice statement)
- relation of menu dependencies and the enclosed config statements
- order dependence between prompts, defaults and dependencies?
- ...

1. basic config statements:

- "config"
- "choice" - "endchoice"
- "source"
- "comment"
- "menu" - "endmenu"
- "mainmenu"

These basic statements start at the beginning of the line. The reason
for this that preceding help entries stop as soon as they find a line
that doesn't start with a space or tab character. This is the best
compromise I found between easy parsing and easy editing of the config.

2. dependencies

Dependencies describe in first place the relation between configuration
symbols and consequently between different parts of the kernel. To
simplify the verification of the rule base, dependencies must be
hierarchical, that means no recursive dependencies are allowed. The only
possible non-hierarchical dependency are exclusions (aka choices), to
cover typical uses during kernel configuration the semantic of choice
statements has been extended (see the choice statement below).
(Currently only the converter warns about recursive dependencies and can
convert some into the new choice syntax).
This allows to describe the following basic relationships:
- initialization order of kernel subsystems. That means which other
  subsystems are required (initialized and working), before a specific
  subsystem can be initialized itself. This allows above requirement of
  hierarchical dependencies.
- mutual exclusions of kernel subsystems. This allows that only a single
  of multiple possible subsystems is configured into the kernel.
These are the same relationships, which are reasonably representable
with cml1, but with this new config syntax it should be possible to
easily add further relationships and other properties.

The important usage of the dependency information is for generation of
the menu structure. First it defines whether a symbol or statement is
visible at all. If the dependency expression evaluates to 'n', the symbol
is not visible (and is currently also not saved, this BTW corresponds to
the behavior of xconfig, which is noted as a bug in Documentation/
kbuild/config-language.txt, that didn't seem to be a problem so far, but
that has to be considered).
If a symbol is visible, it defines the possible input range for tristate
symbols, if the dependency expression evaluates to 'm', a tristate symbol
can only be set to 'n' or 'm', otherwise also 'y' is possible.
Finally dependency information is also used to group symbols together.
If a symbol entry is followed by other symbol entries which depends on
the first one, the latter entries are associated with the first entry.
The text config front end uses this information to automatically indent
the entries, the qt interface creates further submenus. This can reduce
the amount of explicit menu information required.

syntax:

This is the syntax of dependency expressions in a yacc-like syntax:

/expr/:	  /symbol/			(1)
	| /symbol/ "=" /symbol/		(2)
	| /symbol/ "!=" /symbol/	(3)
	| "(" /expr/ ")"		(4)
	| "!" /expr/			(5)
	| /expr/ "&&" /expr/		(6)
	| /expr/ "||" /expr/		(7)

Expressions are listed in  decreasing order of precedence. An
expression can have a value of 'n', 'm' or 'y' (or 0, 1, 2 respectively
for calculations below).
Every symbol has a name and a value. The name of a symbol can contain
any character, names containing a space or tab character have to be
quoted using single or double quotes (only when a symbol is defined
further restrictions are applied to the name). The possible values of a
symbol depends on its type (boolean, tristate, int, hex, string...). If
a symbol has no type, the name and value are equal. A quoted symbol is
not equal to the unquoted variant and has never a type (the reason for
this is that FOO="FOO" works as expected).
Maybe it's better to ignore above (which basically exposes too much the
implementation and which doesn't exist in this way yet, anyway) and just
follow these basic rules:
- always quote hex, int and string values.
- never quote the name of config symbols.

expression syntax:

(1) Convert the symbol into an expression. Boolean and tristate symbols
    are simply converted into the respective expression values. Symbols
    with an unknown type are currently converted into 'y' due to
    compatibility reasons with cml1, but that will likely change.
(2) If the values of both symbols are equal, it returns 'y', otherwise 'n'.
(3) If the values of both symbols are equal, it returns 'n', otherwise 'y'.
(4) Returns the value of the expression. Used to override precedence.
(5) Returns the result of (2-/expr/).
(6) Returns the result of min(/expr/, /expr/).
(7) Returns the result of max(/expr/, /expr/).

3. "config"

syntax:

  "config" /symbol/
  /config options/

defines a new config symbol. defining the same config symbol multiple
times is currently undefined.

config options:

  "depends" /expr/

defines the visibility and the input range of the config symbol.

  "tristate" /prompt/ "if" /expr/
  "boolean" /prompt/ "if" /expr/
  "int" /prompt/ /symbol/ "if" /expr/
  "hex" /prompt/ /symbol/ "if" /expr/
  "string" /prompt/ /symbol/ "if" /expr/

defines the type of the symbol and the prompt which is used to request a
value from the user. Additional constraints for the visibility and the
input range of the prompt can be defined after an "if" statement. The
prompt and the "if" statement are optional, but an "if" statement
without a prompt is not possible.

  "prompt" /prompt/ /symbol/ "if" /expr/

same as above, but without defining the type of the symbol. This was
generated by earlier versions of the converter and will likely
disappear unless needed otherwise.

  "default" /symbol/ "if" /expr/

defines a default value for the config symbol. Default values are only
considered if no prompt is visible. Multiple default statements are
possible and the config symbol is assigned to the first default value
which expression evaluates not to 'n'. The "if" statement is optional.

  "help"

defines a help text for this choice statement.

4. "choice"

syntax:

  "choice"
  /choice options/
  /choice block/
  "endchoice"

defines a group of related config statements. There are two types of
choice statements - boolean and tristate.

boolean choice: allows only single config statement to be selected and
set to "y".
tristate choice: extends the boolean choice by also allowing multiple
config statement to be selected, but in this mode these will only be set
"m". This can be used if multiple drivers for a single hardware exists
and only a single driver can be compiled/loaded into the kernel, but all
drivers can be compiled as modules.

choice options:

  "depends" /expr/

defines the visibility and the input range of the choice.

  "prompt" /prompt/

defines the prompt which is presented to the user.

  "optional"

by default exactly one of the config statements of a boolean choice has
to be selected, this option allows that also no config statement has to
be selected.

  "default" /prompt/

defines the default choice presented to the user. The prompt must be a
unique abbreviation of one config statement prompts (This comes from
cml1, I'll probably change it to the name of the config symbol).

  "help"

defines a help text for this choice statement.

choice block:

right now only config statements allowed. (It's possible to also allow
other statements later.)

5. "source"

syntax:

  "source" /symbol/

reads the specified configuration file. this is done unconditionally,
(It could be possible to define base dependencies for the statements in
the config file.)

6. "comment"

syntax:

  "comment" /prompt/
  /comment options/

defines the prompt which is displayed to the user during the
configuration process and is also echoes it to the output files during
output.

comment options:

  "depends" /expr/

defines the visibility of the comment.

7. "menu"

syntax:

  "menu" /prompt/
  /menu options/
  /menu block/
  "endmenu"

menu options:

  "depends" /expr/

defines the visibility of the menu.

menu block:

Any of the basic statements is allowed within a menu block.

8. "mainmenu"

syntax:

  "mainmenu" /prompt/

This is the "mainmenu_name" statement from cml1, unless someone finds a
use for it, it will be dropped soon. It's ignored right now.



