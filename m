Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJNLlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJNLlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:41:52 -0400
Received: from web80702.mail.yahoo.com ([66.163.170.59]:63601 "HELO
	web80702.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262070AbTJNLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:41:36 -0400
Message-ID: <20031014114135.68297.qmail@web80702.mail.yahoo.com>
Date: Tue, 14 Oct 2003 13:41:35 +0200 (CEST)
From: =?iso-8859-1?q?Hartmut=20Zybell?= <u_zybell@yahoo.de>
Subject: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First things first: Please CC me, because I'm not
subscribed.

I need a ld-Script to construct an elf-File that is a
tar-File too. Can
anyone help me? Especially the Checksum is tricky.

The reason I ask this (and an example to see what I
mean) is longer to
explain. There are two variants (and therefore two
examples) where the
easier one has nothing to do with the kernel, so
please bear with me.
First Example: I want to construct a statically linked
program, that
read as tar-File contains the dynamically linked
program and the used
shared library(s), so that I can run it to install a
system, where no
/lib/ld-linux.so is and can free the diskspace later
when there is.
As picture:
    Seen as elf                      Seen as tar
  +-------------------+           +--------------+---+
  |   ELF-Header      |           |   File-Name  |   |
  +-------------------+           +--------------'   |
  | Garbage           |           |   tar-header     |
  +-------------------+           +------------------+
  |   Programheader   |           |    Content of    |
  |  and Relocations  |           |    file \x7fELF  |
  |  for statically   |           |   (Garbage)      |
  |  linked version   |           |                  |
  +-------------------+           +------------------+
  |                   |           |   tar-header     |
  |                   |           +--------------+---+
  |                   |           |   ELF-Header |   |
  |                   |           +--------------'   |
  |    Garbage        |           | Content of dyna- |
  |                   |           | mically linked   |
  |                   |           | Program          |
  |                   |           +--------------+   |
  |                   |           |Programheader |   |
  |                   |           |and Relocation|   |
  +-------------------+           +--------------+   |
  |  Programcode      |           |   Programcode    |
  |  (.text+.data)    |           | (.text+.data)    |
  +-------------------+           +------------------+
  |                   |           |   tar-header     |
  |                   |           +--------------+---+
  |                   |           |   ELF-Header |   |
  |                   |           +--------------'   |
  |    Garbage        |           | Content of dyna- |
  |                   |           | mically linked   |
  |                   |           | Library          |
  |                   |           +--------------+   |
  |                   |           |Programheader |   |
  |                   |           |and Relocation|   |
  +-------------------+           +--------------+   |
  |  Librarycode      |           |   Librarycode    |
  |  (.text+.data)    |           | (.text+.data)    |
  +-------------------+           +------------------+

That lays the Groundwork for the second Example and
for the Architecture of
Kernel 3.0. The idea is that the kernel is booted like
a statically linked
Program, but loading modules is like shared librarys.
After we have seen
above, that both could be combined in a single file,
we can predict the
Architecture as follows. Every byte in the kernel is
owned by a module or
a process. The process-owned bytes don't concern us
here, so I will ignore
them in my explanation. The in-memory image of the
kernel will be as if a
hypothetical module-loader had loaded all compiled-in
modules from an also
hypotehtical source into the memory. The only
difference of a compiled-in
module and its to-be-loaded counterpart is that its
name ends in the version
number of the kernel. Every compiled-in module gets a
tar-header in the kernel
image. The first tar-header, and therefore the
"static" image, is for a piece
of setup code that corrects the page tables to free
garbage and duplicated
entries. All pieces of code that are currently not
loadable (VFS,scheduler etc.)
get a module header, but directly or indirectly the
module loader (a module
too) or the personality (modules too) of a process
depends on them, so they
could not be removed without replacing them or
removing the module loader, the
very tool with which the removing is done.
Replacing a module will be a new technology that
allows the update of the
kernel in the running system. To do this, the updated
module must be extracted
from the new kernel (that must be a tar-file therefore
too) with either
          tar xzf vmlinux module.ko       (Please
note: no version in name)
  or
          tar xf vmlinuz -O k|tar xz module.ko    (x86
and compatible).
Then it will be insmod. Then a rmmod module-old (where
old is the old version
number) will trigger the replacement going which works
like this:
Any module that needs the services of another module
requests them by symbol.
The module that provides that symbol has in its module
header a version
independent name (the beginning of the module name).
The rest (the version) is
the name of another module that is called the symbol
table. If it's blank it's
the table for to-be-loaded modules. Therefore symbol
tables are separated by
version.
If a module is loaded that has the same version
independent name its symbols
will go into another symbol table. To resolve a symbol
the symbol will be
first searched in the symbol table of the same
version, then in the version
independent symbol table (where symbols of
to-be-loaded modules go), then in
other versions in version decreasing order. If a
module is to be removed and
is needed by another module and there is another
module with the same version
independent name, all dependent modules will be
notified and must reresolve
their symbols.

The infrastructure to reresolve the symbols is the
second task the linker must
do after placing the modules in tar-headers. It's like
the global object table
in dynamic linking. The notifcation infrastructure
must be either erected by
the module loader (by spending a notification function
for every global object)
or must be contained in the symbol table by making
that a full fledged dynamic
loader. I like the first alternative better.

BTW, the module loader shouldn't contain any struct
Elf_*, but should rely on
binfmt(_elf) for that. So could even the binary format
of the modules (and of
the kernel therefore) change without reboot.

This Architecture gives us for free updateability of
drivers for boot media,
kexec, switchable scheduler, fixed modules after boot
with modules and probably
many more applications.



__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Logos und Klingeltöne fürs Handy bei http://sms.yahoo.de
