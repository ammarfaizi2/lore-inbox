Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSDJCl4>; Tue, 9 Apr 2002 22:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSDJCl4>; Tue, 9 Apr 2002 22:41:56 -0400
Received: from rj.SGI.COM ([204.94.215.100]:43943 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S312374AbSDJCly>;
	Tue, 9 Apr 2002 22:41:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Sun, 07 Apr 2002 22:27:40 CST."
             <200204080427.g384Re999479@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 12:41:43 +1000
Message-ID: <2317.1018406503@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2002 22:27:40 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>kaos wrote
>>Having multiple conglomerates gets messy, especially if you allow a
>>mixture of built in and modular selection and if it is possible for
>>everything to be a module with no built in stubs.  The generic case
>>looks like this
>
>Since this is the case, and the Makefile will return to this format
>as soon as the U320 driver is released, can we come up with an
>interrim Makefile that assumes the new driver will show up shortly?

I renew my standing offer that goes back to June 2001.  If you agree to

* use the standard Linux kernel build methods
* stop shipping files and overwriting them at run time
* make the decision about firmware generation automatic instead of
  manual
* remove the BSD'isms from the Linux aic7xxx Makefiles

then I will happily write clean aic7xxx makefiles and support them.
But if you insist on doing it your own way that does not match the
Linux kernel build, then I am afraid that you are on your own.


Why shipping files and overwritten them at build time is a bad idea,
and why relying on a manual switch to regenerate files is the lazy
approach.  From kbuild-2.5/Documentation/kbuild/kbuild-2.5.txt.

SHIPPING GENERATED FILES

  In general it is bad practice to include generated files in the kernel
  source tree.  The only exceptions are when the generating code is not in
  the kernel or when the generating code is in the kernel but it requires
  additional tools which not all users have installed.  An example of a
  generated file without the code to regenerate it is firmware for a network
  driver.  An example of a generation process that requires extra tools is
  drivers/char/defkeymap.c which requires the loadkeys program.

  There is no justification for shipping any other generated file as part of
  the kernel.  This is especially true if the user is always expected to
  regenerate the file, even more so if the generated data depends upon the
  user's .config.  Under these circumstances it is dangerous to ship a
  generated file because it can be used when it does not reflect the user's
  kernel.

  When a generated file has no kernel support to regenerate it, the file can
  be shipped as is.  The question of whether including generated files in the
  kernel without the underlying code is a violation of the kernel license is
  outside the scope of this document.

  For generated files where the code is included but not all users can run
  it, you must be careful about when the generated file is rebuilt.  make
  looks at the time stamp of the generating and generated files to decide if
  the output needs to be regenerated.  This works for the person making the
  changes because they control when the files are updated.

  Time stamps do not work when the change is issued to the rest of the world
  as a diff.  After patch has run you cannot guarantee which of the updated
  files has the more recent time.  The patch program does not preserve time
  stamps (it must not) so the time stamps on the changed files depend on the
  order of the entries in the patch set.  There is no defined order for
  entries in a patch set, it depends on the program that generated the
  difference listing.  GNU diff generates patches in alphabetical order but
  only when it is given an entire directory.  When diff is invoked from a
  source repository tool it is typically called once for each file and the
  file order is controlled by the repository tool.  Even if your repository
  generates the patch in the correct order, that order can change when the
  patch is merged into the kernel.

  Since you cannot rely on time stamps to decide if a generated and shipped
  file needs to be regenerated, you must use another mechanism for this case.
  There are two basic possibilities, manual or automatic (otherwise known as
  lazy or correct).

  In the manual case you ignore changes to the generated or generating files
  until the user performs some manual operation, such as selecting
  CONFIG_REGENERATE_foo.  This is easy to implement but it is also the lazy
  approach, making the end user do extra work to save the maintainer doing
  anything.  This goes against the whole idea of *automatically* deciding
  what needs to be rebuilt, instead it relies on human intervention.

  In the automatic case the maintainer has to do more work but the make rules
  can automatically determine if the end user has changed any of the related
  files and regenerate automatically.  This is the correct approach.  In the
  absence of reliable time stamps you need another method to check if the
  generating and generated files are in sync or not.  The obvious method is a
  checksum of files.

  Given a generated file 'foo' and a script to generate it 'foo-gen' which
  not all users can run because they may not have the required software
  installed.

    foo_files := $(srcfile foo-gen) $(srcfile foo.out_shipped)
    $(objfile foo_sum.d): $(srcfile foo_sum) $(foo_files)
            $(KBUILD_QUIET)(set -e;
	      mkdir -p $(objdir); \
              sed -e 's:$$[ABD-Z][^$$]*\$$::g' $(foo_files) > \
                $(objfile .tmp_foo_files); \
              ($(MD5SUM) -c $(srcfile foo_sum) >/dev/null 2>&1 && \
                echo S OK || echo F) > $@; \
              rm $(objfile .tmp_foo_files); \
            )

    user_command(foo.out
            ($(objfile foo_sum.d))
            ([ "`cat $<`" = "S OK" ] &&
              (cp $(srcfile $(@F)_shipped) $@) ||
              (set -ex ; $(srcfile foo-gen) > $(objfile foo.out)))
            ()
            )

    # Exception: this writes to the source tree.  The target must be
    # explicitly requested.
    .PHONY: foo_sum_shipped
    foo_sum_shipped: $(objfile foo.out)
            @cmp -s $(objfile foo.out) $(srcfile foo.out_shipped) || \
                 mv $(objfile foo.out) $(srcfile foo.out_shipped)
            @( \
             set -e; \
             sed -e 's:$$[ABD-Z][^$$]*\$$::g' $(foo_files) > \
                $(objfile .tmp_foo_files); \
              $(MD5SUM) $(objfile .tmp_foo_files) > $(objfile .tmp_$(@F)) && \
              cmp -s $(objfile .tmp_$(@F)) $(srcfile foo_sum) || \
                (echo Updating checksum for foo; \
                 mv $(objfile .tmp_$(@F)) $(srcfile foo_sum)); \
            )
            @rm -f $(objfile foo_sum.d) $(objfile .tmp_$(@F)) \
              $(objfile .tmp_foo_files)

    ifsel(CONFIG_foo)
      all_sum_shipped: foo_sum_shipped
    endif

  That is boiler plate code which can be used for any shipped files, by
  globally replacing 'foo-gen' and 'foo'.  To initialize the sequence, touch
  $(srcfile foo_sum) and $(srcfile foo.out_shipped) then make
  foo_sum_shipped.  Thereafter any real change to the foo files will
  regenerate foo, ignoring any spurious time stamp differences caused by
  patch.  It removes all need for special configuration options, if anybody
  changes the input files then kbuild automatically rebuilds foo when it is
  used.  Users who do not change the input files get the shipped version when
  foo is required.

    foo_files       - List all the source files, including the generating
                      code and the shipped version of foo.  The list does not
                      include foo_sum.
    foo_sum         - Checksum over $(foo_files), i.e. the master copies.
                      The checksum ignores RCS id and date strings.
    foo_sum.d       - Built on the first make and when any of the input files
                      are updated after the first make.  foo_sum.d either
                      contains 'S OK' (sum is valid) or 'F' (failed).
    user_command    - Creates the working copy of foo, either from the
                      shipped copy (sum is valid) or by running foo-gen (sum
                      does not match, a real change has occurred).  Watch the
                      parenthesis in the user_command, in particular the use
                      of foo-gen requires () around the set of commands.
    foo_sum_shipped - Takes the latest version of foo, generating it if
                      necessary and writes it back to the source tree as
                      foo.out_shipped.  Generates a new checksum
                      automatically.  Note: This command must be manually
                      specified by the foo maintainer before shipping a new
                      version of foo.

  For a concrete example, see defkeymap.c in drivers/char/Makefile.in.

  Because this is boiler plate code, it has been automated.

    shipped(prefix
             (generated files)
             (generating files)
             (commands to create all the generated files)
             (CONFIG dependencies to select all_sum_shipped)
           )

  The first field is the prefix for variables and for _sum files.  It must be
  globally unique in the kbuild files.

  The generated files are bare names, without '/', without '_shipped', no
  $(objfile) or $(srcfile) is allowed, in fact no $(variables) are accepted.
  These names are used to create the user_command() and the 'cp' commands,
  one for each generated file.  Because user_command() only takes one target,
  all the other generated files are defined as side_effect()s of the last
  target, you must list the generated files in the order that they are
  created by your commands.

  The generating files are bare names and list the source files used to
  generate the targets.  For example, scripts, tables, lex or yacc code.

  The commands define how you create the target files if the shipped versions
  of the targets are no longer valid, i.e. the checksum has failed.  I
  recommend that the first command is 'set -ex;'.

  The config dependencies are zero or more configs to check.  If any are
  selected then all_sum_shipped is extended with foo_sum_shipped.

  The code above shrinks to these few lines.

    shipped(foo
             (foo.out)
             (foo-gen)
             (set -ex ; $(srcfile foo-gen) > $(objfile foo.out))
             (CONFIG_foo)
           )

