Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVBMBJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVBMBJq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVBMBJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 20:09:46 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:35976 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261228AbVBMBJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 20:09:36 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sun, 13 Feb 2005 02:07:58 +0100
To: george@mvista.com, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH][2.6-mm] kgdb documentation fix
Message-ID: <20050213010758.GA15159@kiste>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please apply.

---=20

Update Documentation/i386/kgdb/gdbinit-modules to conform
to the current kernel's module data structure.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

---=20

=3D=3D=3D=3D=3D Documentation/i386/kgdb/gdbinit-modules 1.1 vs edited =3D=
=3D=3D=3D=3D
--- 1.1/Documentation/i386/kgdb/gdbinit-modules	2005-02-12 12:44:54 +01:00
+++ edited/Documentation/i386/kgdb/gdbinit-modules	2005-02-12 20:12:45 +01:=
00
@@ -60,87 +60,90 @@
 # $mod is set to NULL.  This ensure to not add symbols for a wrong
 # address.
 #
+#=20
+# Sat Feb 12 20:05:47 CET 2005
+#
+# Adapted to the 2.6.* module data structure.
+# (Getting miffed at gdb for not having "offsetof" in the process :-/ )
+#=20
+# Autogenerate add-symbol-file statements from the module list instead
+# of relying on a no-longer-working loadmodule.sh program.
+#=20
+#                                   Matthias Urlichs <smurf@debian.org>
+#
+#
 # Have a nice hacking day !
 #
 #
 define mod-list
-    set $mod =3D (struct module*)module_list
-    # the last module is the kernel, ignore it
-    while $mod !=3D &kernel_module
-    	printf "%p\t%s\n", (long)$mod, ($mod)->name
-	set $mod =3D $mod->next
+    set $lmod =3D modules->next
+    # This is a circular data structure
+    while $lmod !=3D &modules
+		set $mod =3D (struct module *)(((char *)$lmod) - ((int)&(((struct module=
 *)0) -> list)))
+        printf "%p\t%s\n", $mod, $mod->name
+		set $lmod =3D $lmod->next
     end
 end
 document mod-list
+mod-list
 List all modules in the form: <module-address> <module-name>
 Use the <module-address> as the argument for the other
 mod-commands: mod-print-symbols, mod-add-symbols.
 end
=20
+define mod-list-syms
+    set $lmod =3D modules->next
+    # This is a circular data structure
+    while $lmod !=3D &modules
+		set $mod =3D (struct module *)(((char *)$lmod) - ((int)&(((struct module=
 *)0) -> list)))
+        printf "add-symbol-file %s.ko %p\n", $mod->name, $mod->module_core
+		set $lmod =3D $lmod->next
+    end
+end
+document mod-list-syms
+mod-list-syms
+List all modules in the form: add-symbol-file <module-path> <module-core>
+for adding modules' symbol tables without loadmodule.sh.
+end
+
 define mod-validate
-    set $mod =3D (struct module*)module_list
-    while ($mod !=3D $arg0) && ($mod !=3D &kernel_module)
-    	set $mod =3D $mod->next
+    set $lmod =3D modules->next
+	set $mod =3D (struct module *)(((char *)$lmod) - ((int)&(((struct module =
*)0) -> list)))
+    while ($lmod !=3D &modules) && ($mod !=3D $arg0)
+        set $lmod =3D $lmod->next
+	    set $mod =3D (struct module *)(((char *)$lmod) - ((int)&(((struct mod=
ule *)0) -> list)))
     end
-    if $mod =3D=3D &kernel_module
-	set $mod =3D 0
-    	printf "%p is not a module\n", $arg0
+    if $lmod =3D=3D &modules
+    	set $mod =3D 0
+        printf "%p is not a module\n", $arg0
     end
 end
 document mod-validate
 mod-validate <module-address>
 Internal user-command used to validate the module parameter.
-If <module> is a real loaded module, set $mod to it otherwise set $mod to =
0.
+If <module> is a real loaded module, set $mod to it, otherwise set $mod
+to 0.
 end
=20
-
 define mod-print-symbols
     mod-validate $arg0
     if $mod !=3D 0
-	set $i =3D 0
-	while $i < $mod->nsyms
-	    set $sym =3D $mod->syms[$i]
-	    printf "%p\t%s\n", $sym->value, $sym->name
-	    set $i =3D $i + 1
-	end
+		set $i =3D 0
+		while $i < $mod->num_syms
+			set $sym =3D $mod->syms[$i]
+			printf "%p\t%s\n", $sym->value, $sym->name
+			set $i =3D $i + 1
+		end
+		set $i =3D 0
+		while $i < $mod->num_gpl_syms
+			set $sym =3D $mod->gpl_syms[$i]
+			printf "%p\t%s\n", $sym->value, $sym->name
+			set $i =3D $i + 1
+		end
     end
 end
 document mod-print-symbols
 mod-print-symbols <module-address>
-Print all exported symbols of the module.  see mod-list
-end
-
-
-define mod-add-symbols-align
-    mod-validate $arg0
-    if $mod !=3D 0
-	set $mod_base =3D ($mod->size_of_struct + (long)$mod)
-	if ($arg2 !=3D 0) && (($mod_base & ($arg2 - 1)) !=3D 0)
-	    set $mod_base =3D ($mod_base | ($arg2 - 1)) + 1
-	end
-	add-symbol-file $arg1 $mod_base
-    end
-end
-document mod-add-symbols-align
-mod-add-symbols-align <module-address> <object file path name> <align>
-Load the symbols table of the module from the object file where
-first section aligment is <align>.
-To retreive alignment, use `objdump -h <object file path name>'.
+Print all exported symbols of the module.  See mod-list
 end
=20
-define mod-add-symbols
-    mod-add-symbols-align $arg0 $arg1 sizeof(long)
-end
-document mod-add-symbols
-mod-add-symbols <module-address> <object file path name>
-Load the symbols table of the module from the object file.
-Default alignment is 4.  See mod-add-symbols-align.
-end
-
-define mod-add-lis
-    mod-add-symbols-align $arg0 /usr/src/LiS/streams.o 16
-end
-document mod-add-lis
-mod-add-lis <module-address>
-Does mod-add-symbols <module-address> /usr/src/LiS/streams.o
-end

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCDqhu8+hUANcKr/kRAh0YAKCEeXSwiG1rd/nH4Zm7IwggSR86JwCZAQhW
CGQZqmjGWrlaSIIGKZBEMLg=
=b6QT
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
