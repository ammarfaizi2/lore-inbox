Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUBMXkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267221AbUBMXkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:40:32 -0500
Received: from smtp06.auna.com ([62.81.186.16]:4814 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264353AbUBMXka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:40:30 -0500
Date: Sat, 14 Feb 2004 00:40:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: strxxx and gcc-3.4
Message-ID: <20040213234028.GA3765@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Finally I got the problem with emu10k1. It was a sprintf->strcpy that
the compiler could not inline. And out-of-line strcpy was not exported.
Exporting it solved the problem (in -mm tree, that has the out-of-line
versions).

Current situation: even -mm, that includes many fixes for gcc-3.4, can
fail to build. Currently in 2.6.3-rc2-mm1 there are:

werewolf:/usr/src/linux-2.6.3-rc2-mm1# grep -r sprintf * | grep \"%s\" | wc -l
63

instances of that stupid sprintf(s,"%s", .... ) thing.

Options:
- Fix all of them. I don't like it, the kernel should not depend on what
  gcc does internally
- Use -fno-builtin-sprintf. I think gcc swaps sprintf to strcpy because
  it sees it as a builtin, but as finds a declaration for an external
  strcpy does not use the builtin for strcpy.
- Kill off all str/mem functions and just let gcc insert builtins.

  info for gcc-3.3 says:

   The ISO C90 functions `abs', `cos', `exp', `fabs', `fprintf',
`fputs', `labs', `log', `memcmp', `memcpy', `memset', `printf',
`putchar', `puts', `scanf', `sin', `snprintf', `sprintf', `sqrt',
`sscanf', `strcat', `strchr', `strcmp', `strcpy', `strcspn', `strlen',
`strncat', `strncmp', `strncpy', `strpbrk', `strrchr', `strspn',
`strstr', `vprintf' and `vsprintf' are all recognized as built-in
functions unless `-fno-builtin' is specified (or
`-fno-builtin-FUNCTION' is specified for an individual function).  All
of these functions have corresponding versions prefixed with
`__builtin_'.

  info for gcc-3.4

   The ISO C90 functions `abort', `abs', `acos', `asin', `atan2',
`atan', `calloc', `ceil', `cosh', `cos', `exit', `exp', `fabs',
`floor', `fmod', `fprintf', `fputs', `frexp', `fscanf', `labs',
`ldexp', `log10', `log', `malloc', `memcmp', `memcpy', `memset',
`modf', `pow', `printf', `putchar', `puts', `scanf', `sinh', `sin',
`snprintf', `sprintf', `sqrt', `sscanf', `strcat', `strchr', `strcmp',
`strcpy', `strcspn', `strlen', `strncat', `strncmp', `strncpy',
`strpbrk', `strrchr', `strspn', `strstr', `tanh', `tan', `vfprintf',
`vprintf' and `vsprintf' are all recognized as built-in functions unless
`-fno-builtin' is specified (or `-fno-builtin-FUNCTION' is specified
for an individual function).  All of these functions have corresponding
versions prefixed with `__builtin_'.

So at least the common interesting things are
 `memcmp', `memcpy', `memset'
 `strcat', `strchr', `strcmp', `strcpy', `strcspn', `strlen',
 `strncat', `strncmp', `strncpy', `strpbrk', `strrchr', `strspn', `strstr', 
 `sprintf', `snprintf', `sscanf', `vsprintf'

Preferences ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (RC1) for i586
Linux 2.6.3-rc2-jam1 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.1mdk))
