Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSHBVLL>; Fri, 2 Aug 2002 17:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSHBVLL>; Fri, 2 Aug 2002 17:11:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15624 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317073AbSHBVLI>;
	Fri, 2 Aug 2002 17:11:08 -0400
Date: Fri, 2 Aug 2002 23:22:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] automatic module_init ordering
Message-ID: <20020802232232.A25583@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>
References: <E17aPjw-0007zG-00@scrub.xs4all.nl> <Pine.LNX.4.44.0208012156460.24984-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208012156460.24984-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Thu, Aug 01, 2002 at 10:19:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 10:19:04PM -0500, Kai Germaschewski wrote:
> and the like, since otherwise my shell (bash) would complain about an
> empty "for o in ; do". Maybe there's a less hacky way to handle that? 
Found what I consider less hacky way to handle it.
Test for non-empty string before executing the for loop.
Also played a little with gen_builtin_mod to make it cover all combinations
of empty and non-empty directories.

> 
> BTW, it'd be also nice if scripts/build-initcalls would add some \n's to
> init/generated-initcalls.c ;)
Done.

I also made a few other changes to allow my kernel to compile.
Patch is on top of Kai's KBUILD_MODNAME and Romans latest version.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.564   -> 1.565  
#	            Makefile	1.284   -> 1.285  
#	          Rules.make	1.70    -> 1.71   
#	scripts/build-initcalls	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	sam@mars.ravnborg.org	1.565
# [PATCH] Automatic initcall can compile 2.5.30
# o No longer fails with minimal config
# o bash compatible
# o generated-initcalls.c readable
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Aug  2 23:15:54 2002
+++ b/Makefile	Fri Aug  2 23:15:54 2002
@@ -291,7 +291,9 @@
 	$(CONFIG_SHELL) -e scripts/build-initcalls $< $@
 
 .allbuiltin_mods: $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
-	for s in $(dir $^); do sed "s,^,$$s," < $${s}.builtin_mods; done > $@
+	@$(if $^,\
+	for s in $(dir $^); do sed "s@^@$$s@" \
+	< $${s}.builtin_mods; done > $@ )
 
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Fri Aug  2 23:15:54 2002
+++ b/Rules.make	Fri Aug  2 23:15:54 2002
@@ -320,16 +320,20 @@
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
-quiet_cmd_gen_builtin_mod = '  Generating $(echo_target)'
+quiet_cmd_gen_builtin_mod = MOD    $(echo_target)
 define cmd_gen_builtin_mod
-	for o in $(sort $(local-objs-y)); do \
-	  if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
-	    echo $$o; \
-	  fi \
-	done > $@; \
+	(echo $(if $(local-objs-y),;) \
+	$(if $(local-objs-y), \
+	  for o in $(sort $(local-objs-y)); do \
+	    if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
+	      echo $$o; \
+	    fi \
+	  done) \
+	$(if $(subdir-y), ;\
 	for s in $(sort $(subdir-y)); do \
-	  sed "s,^,$$s/," < $$s/.builtin_mods; \
-	done >> $@
+	  sed "s@^@$$s/@" < $$s/.builtin_mods; \
+	done) \
+	) > $@
 endef
 
 $(subdir-y:%=%/.builtin_mods): sub_dirs
diff -Nru a/scripts/build-initcalls b/scripts/build-initcalls
--- a/scripts/build-initcalls	Fri Aug  2 23:15:54 2002
+++ b/scripts/build-initcalls	Fri Aug  2 23:15:54 2002
@@ -7,7 +7,10 @@
 
 # get all global defined/undefined symbols and sort them into the right files
 while read obj; do
-  $NM $obj | sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $(echo $obj | sed s/,/\\\\,/),p"
+  if [ -f $obj ]; then
+    $NM $obj |\
+      sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $(echo $obj | sed s/,/\\\\,/),p"
+  fi
 done < $list |
 awk '/^U/ { print $2 " " $3 | "sort -u > .undefined.tmp" }
      /^[TD]/ { print $2 " " $3 | "sort -u > .defined.tmp" }'
@@ -19,17 +22,26 @@
 
 # extract init function call and prepare declarations and array
 while read obj; do
-  call=$($OBJDUMP -t $obj | awk '/F \.initcall\.module/ { print $6 }')
-  defs="$defs extern int $call(void);"
-  arr="$arr $call,"
+  if [ -f $obj ]; then
+    call=$($OBJDUMP -t $obj | awk '/F \.initcall\.module/ { print $6 }')
+    defs="$defs extern int $call(void);"
+    arr="$arr $call"
+  fi
 done < .sorted.tmp
 
 # finally write it
-echo "#include <linux/init.h>" > $initsrc
-echo $defs >> $initsrc
-echo 'initcall_t generated_initcalls[] = {' >> $initsrc
-echo $arr >> $initsrc
-echo '0 };' >> $initsrc
+(
+echo "#include <linux/init.h>"
+for i in $arr; do
+  echo "extern int $i(void);"
+done
+echo
+echo 'initcall_t generated_initcalls[] = {'
+for i in $arr; do
+  echo "$i, "
+done
+echo '0 };'
+) > $initsrc
 
 # clean up
-rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp
+#rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp
