Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269474AbRHGVwL>; Tue, 7 Aug 2001 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269473AbRHGVwD>; Tue, 7 Aug 2001 17:52:03 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17144 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269468AbRHGVvt>;
	Tue, 7 Aug 2001 17:51:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 7 Aug 2001 21:51:06 GMT
Message-Id: <200108072151.VAA25091@vlet.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [RFC][PATCH] parser for mount options
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, folks - here's an implementation of parser for mount options.

Good!

I did the same for 1.3.61 long ago. A fragment:

(for msdos)

+       struct {
+         int check, conversion, uid, gid, umask;
+         int blksize, fat, debug, quiet, dotsOK, sys_immutable;
+       } opt = {
+         'n', 'b', current->uid, current->gid, current->fs->umask,
+         512, 0, 0, 0, 0, 0
+       };
+
+       typedef char *(C[]);
+       struct mount_option opts[] = {
+         { "check", OPT_STRING,
+             &(C){"relaxed", "normal", "strict", 0}, &opt.check},
+         { "conv", OPT_STRING,
+             &(C){"binary", "text", "auto", 0}, &opt.conversion},
+         { "uid", OPT_INT, 0, &opt.uid},
+         { "gid", OPT_INT, 0, &opt.gid},
+         { "umask", OPT_INT_8, 0, &opt.umask},
+         { "blocksize", OPT_INT, 0, &opt.blksize},
+         { "fat", OPT_INT, 0, &opt.fat},
+         { "debug", OPT_BOOL_01, 0, &opt.debug},
+         { "quiet", OPT_BOOL_01, 0, &opt.quiet},
+         { "dots", OPT_BOOL_NY, 0, &opt.dotsOK},
+         { "dotsOK", OPT_STRING, &(C){"yes", "no", 0}, &opt.dotsOK},
+         { "sys_immutable", OPT_BOOL_01, 0, &opt.sys_immutable}
+       };

(for iso9660)

+       struct {
+         int map, rock, cruft, unhide, check;
+         int conversion, blocksize, mode, uid, gid;
+       } opt = {
+         'n', 'y', 'n', 'n', 's',
+         'b', 1024, S_IRUGO, 0, 0
+       };
+
+       typedef char *(C[]);
+       struct mount_option opts[] = {
+         { "map", OPT_STRING, &(C){"normal", "off", 0}, &opt.map},
+         { "rock", OPT_BOOL_NY, 0, &opt.rock},
+         { "cruft", OPT_BOOL_NY, 0, &opt.cruft},
+         { "unhide", OPT_BOOL_NY, 0, &opt.unhide},
+         { "check", OPT_STRING, &(C){"relaxed", "strict", 0}, &opt.check},
+         { "conv", OPT_STRING,
+             &(C){"binary", "text", "mtext", "auto", 0}, &opt.conversion},
+         { "blocksize", OPT_INT, 0, &opt.blocksize}, /* used to be "block" */
+         { "mode", OPT_INT_8, 0, &opt.mode},      /* used to be OPT_INT_10 */
+         { "uid", OPT_INT, 0, &opt.uid},
+         { "gid", OPT_INT, 0, &opt.gid}
+       };

with call for each filesystem

	parse_mount_options((char *) data, SIZE(opts), opts);

I am not sure which of the two versions I prefer.
For example, the above setup shows very clearly what the defaults are.

Also, you still have a lot of code for each filesystem
that calls strtok() and math_token() and does a switch().
I only have this single call parse_mount_options()
for each filesystem.
(And in the past strtok() has caused bugs because it modifies
the string it is called with. Sometimes, as in the case of vfat/msdos,
several filesystems might want to have a look.)

If you don't have any devastating comments I might brush off
this 1.3.61 patch and move it to 2.4.

Andries


PS - Let me add the code for parse_mount_options():

+/*
+ * mount option parsing
+ *
+ * Do not destroy the option string.  Warn for unrecognized options,
+ * but do not fail - they might be for later kernels.
+ */
+static char *handle_option(char *arg, struct mount_option *mo, int no) {
+       char sep = *arg;
+       int eq = (sep == '=');
+       unsigned int val, l, base;
+
+       if (sep)
+               arg++;
+       if (!eq) {
+               if (mo->type & OPT_BOOL_NY) {
+                       *(mo->value) = (no ? 'n' : 'y');
+                       return arg;
+               } else if (mo->type & OPT_BOOL_01) {
+                       *(mo->value) = !no;
+                       return arg;
+               } else
+                       return 0;
+       }
+       if (no || !*arg)
+               return 0;
+
+       if (mo->type & OPT_INT) {
+               switch (mo->type & OPT_INT) {
+               case OPT_INT_8:
+                 base = 8; break;
+               case OPT_INT_10:
+                 base = 10; break;
+               case OPT_INT_16:
+                 base = 16; break;
+               default:
+                 base = 0;
+               }
+               val = simple_strtoul(arg,&arg,base);
+               if (*arg == ',')
+                       arg++;
+               else if (*arg)
+                       return 0;
+               *(mo->value) = val;
+               return arg;
+       }
+
+       if (mo->type & OPT_STRING) {
+         /* For the time being: assume that all string values
+            start with different symbols, and that a string may
+            be abbreviated by its first symbol.
+            Introduce the flag OPT_1_OK and make stringargs an array
+            of (string, value) pairs when that isnt true anymore. */
+
+               char **smo = *(mo->stringargs);
+
+               while(smo && *smo) {
+                       if (**smo != *arg) {
+                               smo++;
+                               continue;
+                       }
+                       l = strlen(*smo);
+                       if (!strncmp(arg, *smo, l))
+                               arg += l;
+                       else
+                               arg++;
+                       if (*arg == ',')
+                               arg++;
+                       else if (*arg)
+                               return 0;
+                       *(mo->value) = **smo;
+                       return arg;
+               }                               
+       }
+       return 0;
+}
+
+int parse_mount_options(char *options, int nmo, struct mount_option *mos) {
+       char sep;
+       int optl, l, n, warned = 0;
+       struct mount_option *mo;
+
+       while (options && (optl = strlen(options)) > 0) {
+           for (n = 0, mo = mos; n < nmo; n++, mo++) {
+               l = strlen(mo->name);
+               if (strncmp(options, mo->name, l) == 0
+                 && ((sep = options[l]) == 0 || sep == ',' || sep == '=')) {
+                   options = handle_option(options+l, mo, 0);
+                   if (!options)
+                       return 0;       /* error */
+                   goto ok;
+               }
+               if ((mo->type & OPT_BOOL)
+                 && strncmp(options, "no", 2) == 0
+                 && strncmp(options+2, mo->name, l) == 0
+                 && ((sep = options[l+2]) == 0 || sep == ',' || sep == '=')){
+                   options = handle_option(options+l+2, mo, 1);
+                   if (!options)
+                       return 0;       /* error */
+                   goto ok;
+               }
+           }
+           if (!warned++)
+               printk("Unrecognized mount option string: %s\n",
+                      options);
+           while (*options && *options++ != ',') ;
+        ok:
+       }
+       return 1;
+}
